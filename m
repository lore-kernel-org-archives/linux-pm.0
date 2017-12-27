From: gaurav jindal <gauravjindal1104@gmail.com>
Subject: Re: [PATCH]cpuidle: preventive check in cpuidle_select against crash
Date: Wed, 27 Dec 2017 07:27:22 +0530
Message-ID: <20171227015722.GA3413@gaurav.jindal>
References: <20171226072626.GA4153@gaurav.jindal>
 <CAJZ5v0g36rdGVDT==CMCsnDFQ6ph2PxOyF0mgdMSfP4Wiv74TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46809 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdL0B50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 20:57:26 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g36rdGVDT==CMCsnDFQ6ph2PxOyF0mgdMSfP4Wiv74TQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Dec 27, 2017 at 01:42:58AM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 26, 2017 at 8:26 AM, gaurav jindal
> <gauravjindal1104@gmail.com> wrote:
> > When selecting the idle state using cpuidle_select, there is no
> > check on cpuidle_curr_governor. In cpuidle_switch_governor,
> > cpuidle_currr_governor can be set to NULL to specify "disabled".
> 
> How exactly?

In cpuidle_switch_governor:
 
/**
 * cpuidle_switch_governor - changes the governor
 * @gov: the new target governor
 *
 * NOTE: "gov" can be NULL to specify disabled
 * Must be called with cpuidle_lock acquired.
 */
int cpuidle_switch_governor(struct cpuidle_governor *gov)
{
	struct cpuidle_device *dev;

	if (gov == cpuidle_curr_governor)
		return 0;

	cpuidle_uninstall_idle_handler();

	if (cpuidle_curr_governor) {
		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
			cpuidle_disable_device(dev);
	}

	cpuidle_curr_governor = gov;

This allows to set the cpuidle_switch_governor as NULL. Although there is no
current code flow leading here, but it has a potential for bug in future. So
may be better to have prevention.
