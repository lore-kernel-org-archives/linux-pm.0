From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Thu, 19 Jan 2017 11:21:58 +0100
Message-ID: <20170119102158.GA1827@mai>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
 <20170117093837.GA2085@mai>
 <01f9b016-0b7c-44ac-70e5-8cd9b8bd1500@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37555 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdASKWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2017 05:22:24 -0500
Received: by mail-wm0-f53.google.com with SMTP id c206so69865848wme.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2017 02:22:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <01f9b016-0b7c-44ac-70e5-8cd9b8bd1500@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>

On Thu, Jan 19, 2017 at 05:25:37PM +0800, Alex Shi wrote:
> 
> > That said, I have the feeling that is taking the wrong direction. Each time we
> > are entering idle, we check the latencies. Entering idle can be done thousand
> > of times per second. Wouldn't make sense to disable the states not fulfilling
> > the constraints at the moment the latencies are changed ? As the idle states
> > have increasing exit latencies, setting an idle state limit to disable all
> > states after that limit may be more efficient than checking again and again in
> > the idle path, no ?
> 
> You'r right. save some checking is good thing to do.

Hi Alex,

I think you missed the point.

What I am proposing is to change the current approach by disabling all the
states after a specific latency.

We add a specific internal function:

static int cpuidle_set_latency(struct cpuidle_driver *drv,
				struct cpuidle_device *dev,
				int latency)
{
	int i, idx;

	for (i = 0, idx = 0; i < drv->state_count; i++) {

		struct cpuidle_state *s = &drv->states[i];			

		if (s->latency > latency)
			break;

		idx = i;
	}

	dev->state_count = idx;

	return 0;
}

This function is called from the notifier callback:

static int cpuidle_latency_notify(struct notifier_block *b,
                unsigned long l, void *v)
 {
-       wake_up_all_idle_cpus();
+       struct cpuidle_device *dev;
+       struct cpuidle_driver *drv;
+
+       cpuidle_pause_and_lock();
+       for_each_possible_cpu(cpu) {
+               dev = &per_cpu(cpuidle_dev, cpu);
+               drv = = cpuidle_get_cpu_driver(dev);    
+               cpuidle_set_latency(drv, dev, l)
+       }
+       cpuidle_resume_and_unlock();
+
        return NOTIFY_OK;
 }

-----------------------------------------------------------------------------

The menu governor becomes:

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index bba3c2af..87e58e3 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -352,7 +352,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
         * Find the idle state with the lowest power while satisfying
         * our constraints.
         */
-       for (i = data->last_state_idx + 1; i < drv->state_count; i++) {
+       for (i = data->last_state_idx + 1; i < dev->state_count; i++) {
                struct cpuidle_state *s = &drv->states[i];
                struct cpuidle_state_usage *su = &dev->states_usage[i];


... with a cleanup around latency_req.

-----------------------------------------------------------------------------

And the cpuidle_device structure is changed to:

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index b923c32..2fc966cb 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -88,6 +88,7 @@ struct cpuidle_device {
        cpumask_t               coupled_cpus;
        struct cpuidle_coupled  *coupled;
 #endif
+       int state_count;
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);


At init time, the drv->state_count and all cpu's dev->state_count are the same.

Well, that is the rough idea: instead of reading the latency when entering
idle, let's disable/enable the idle states when we set a new latency.

I did not check how that fits with the per cpu latency, but I think it will be
cleaner to change the approach rather than spreading latencies dances around.
