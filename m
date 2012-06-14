From: Chao Xie <xiechao.mail@gmail.com>
Subject: PM_RUNTIME and device driver PM
Date: Thu, 14 Jun 2012 11:13:25 +0800
Message-ID: <CADApbejySy-n1+qWmAZ=BrSWBrSV563iCtqB2G3O7+y9BDwDHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

hi
PM_RUNTIME provide a way for device driver do runtime PM. so for some
devices, they have some surrounded logic. For example, the device may
get clock from outside, or it need PHY support(USB is a example).
To get these dependency out of device driver, i define a struct
dev_pm_domain, and make dev.pm_domain point to it. So in the device
driver, when the hardware should be enabled, we can call
pm_runtime_get_sync while when the hardware is idle or does not work,
we can call pm_runtime_put_sync.
It seems work well, but i have question about the suspend/resume of
device. When the whole system will go to deep idle, and it will
suspend the devices. for the function do device suspend
__device_suspend, it will call pm_runtime_get_noresume(dev). As i
think it will make the device not do runtime suspend any more. Is that
correct?
There is the question, how device driver handle the logic surrounds
it? I want to add pm_runtime_put_sync in dev->driver->pm->suspend
function, and pm_runtime_get_sync in dev->driver->pm->resume. Because
__device_suspend increase the usage_count, pm_runtime_put_sync will
not do real work.
So is that right that i directly call pm_runtime_suspend in
dev->driver->pm->suspend and pm_runtime_resume in
dev->driver->pm->resume?
Thanks.
