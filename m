From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v2] suspend/resume performance improvement
Date: Mon, 01 Jun 2015 11:51:20 +0200
Message-ID: <8603263.ZsHYMQGz6a@vostro.rjw.lan>
References: <671217780.313831433048860626.JavaMail.weblogic@epmlwas05b>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <671217780.313831433048860626.JavaMail.weblogic@epmlwas05b>
Sender: linux-kernel-owner@vger.kernel.org
To: eun.taik.lee@samsung.com
Cc: "pavel@ucw.cz" <pavel@ucw.cz>, "len.brown@intel.com" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, May 31, 2015 05:07:42 AM EunTaik Lee wrote:
> When a task that calls state_store() to suspend
> the device has used up most of its time slice,
> suspend sometimes take too long. (User noticeable)

How long?  Perhaps this is not the only explanation of the delay?

> Suspend/resume is a system wide operation.
> So, instead of depending on a userspace task's time
> slice, let kworker do the work to avoid a long wait
> on the runqueue.
> 
> Signed-off-by: Eun Taik Lee <eun.taik.lee@samsung.com>

First, if you send a v2, please say what's changed since v1.

Second, this most likely is hiding a problem of some sort and the theory
about the time slice being used up entirely by the suspend process is not
convincing.

Also the patch duplicates exsiting functionality that should be extended
instead if anything.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
