From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Mon, 15 Dec 2014 17:43:36 +0000
Message-ID: <20141215174336.GJ11285@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <7573578.UE8ufgjWuX@vostro.rjw.lan>
 <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
 <002f01d0186b$2700b730$75022590$%brar@samsung.com>
 <20141215134636.GI11285@n2100.arm.linux.org.uk>
 <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60180 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750863AbaLORnu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 12:43:50 -0500
Content-Disposition: inline
In-Reply-To: <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yadwinder Singh Brar <yadi.brar@samsung.com>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 'Eduardo Valentin' <edubezval@gmail.com>

On Mon, Dec 15, 2014 at 08:24:05PM +0530, Yadwinder Singh Brar wrote:
> > The answer may well be to have finer grained locking here:
> > 
> > - one lock to protect cpufreq_dev_list, which is only ever taken when
> >   adding or removing entries from it
> > 
> > - a second lock to protect cpufreq_dev_count and the calls to
> >   cpufreq_register_notifier() and cpufreq_unregister_notifier()
> > 
> > and you would /never/ take either of those two locks inside each other.
> > In other words:
> > 
> > 	mutex_lock(&cooling_list_lock);
> > 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> > 	mutex_unlock(&cooling_list_lock);
> > 
> > 	mutex_lock(&cooling_cpufreq_lock);
> > 	if (cpufreq_dev_count++ == 0)
> > 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> > 					  CPUFREQ_POLICY_NOTIFIER);
> > 	mutex_unlock(&cooling_cpufreq_lock);
> > 
> > and similar in the cleanup path.  The notifier itself would only ever
> > take the cooling_list_lock.
> > 
> 
> I agree with this approach, if its fine for others also, I can implement
> and post patch.

Yes, please do.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
