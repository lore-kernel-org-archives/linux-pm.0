From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Need help : Way to disable runtime PM with system suspend enabled
Date: Thu, 9 Jun 2016 14:46:34 +0200
Message-ID: <CAJZ5v0jGmgKZscGcq1XRrSW8Lo5-71-VAG4fa+HBO6GVP29=8g@mail.gmail.com>
References: <57277a9454784b2c911a2c90fd1bea3e@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37723 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbcFIMqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 08:46:36 -0400
Received: by mail-wm0-f45.google.com with SMTP id k204so58915028wmk.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jun 2016 05:46:36 -0700 (PDT)
In-Reply-To: <57277a9454784b2c911a2c90fd1bea3e@bgmail103.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sumit Singh <sumsingh@nvidia.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Bharat Nihalani <bnihalani@nvidia.com>

On Thu, Jun 9, 2016 at 9:23 AM, Sumit Singh <sumsingh@nvidia.com> wrote:
> Hi Rafael,

Hi,

> I have a requirement related to runtime PM and system suspend, and need your help for it. Below is the requirement, and the approach I followed:
>
> I want to disable runtime-PM for all the devices, but want to keep system suspend enabled. More precisely, I don't want devices to runtime suspend or even clock-gated when device is idle.
> I want them always to be in full power state. Currently, devices are using runtime PM to get powered at boot time.
>
> I have a requirement where power supply is not a constraint, but system's responsiveness is of critical importance. With runtime-PM enabled, it will incur some delay for the device to come out of runtime suspend state whenever a request comes for it.
> I want to avoid that delay. This is the reason I want to disable runtime PM. System suspend should be working fine.
>
> As upstream has closely integrated runtime PM and system suspend, and also got rid of CONFIG_PM_RUNTIME, so now it is not possible to just disable CONFIG_PM_RUNTIME to disable runtime PM. I tried below two approaches to meet the requirement:
>
> 1.)    The devices that use PM Domains, I set governor as always-on governor, so that devices won't runtime suspend. But, it does not prevent devices from clock-gating. This approach is applicable only for the devices which use PM Domains.
> 2.)    The devices that don't use PM Domains, I tried making changes in individual drivers. For each device, in the probe function, once device is powered-on, I disable runtime PM using runtime PM APIs, so that device won't entertain any
> runtime requests. This way device will be always on.
>
> -  With first approach, devices did not runtime suspend, but were clock-gated. This approach is not applicable to the devices, which don't use PM Domain. System suspend is working fine.
> -  With second approach, devices were not runtime suspended, and were always powered-on. But I had to make changes in each of the driver files. As each of the devices are using runtime PM in different ways, so it was not possible to create a common API which will suit all the devices.
>
> Could you please help me with a cleaner way so that devices don't runtime-suspend (not even clock-gate), and system suspend should be working?

Well, each device has the "control" attribute in sysfs that can be
used to make the device stay in the active metastate all the time.
Why don't you use it?

Thanks,
Rafael
