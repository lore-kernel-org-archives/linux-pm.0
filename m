From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [PATCH] PM/CORE: Fix using sizeof without parenthesis in the sysfs.c
Date: Mon, 28 Jan 2013 09:03:28 +0000
Message-ID: <CAAMvbhEx69V026n4uhyPrq2aOXcx_vR1PQ-1-k2245JvSXQ=6A@mail.gmail.com>
References: <1359361909-28793-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1359361909-28793-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28 January 2013 08:31, Lan Tianyu <tianyu.lan@intel.com> wrote:
> -       if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
> +       if (len == sizeof(ctrl_auto - 1) && strncmp(buf, ctrl_auto, len) == 0)

This looks wrong to me.
sizeof ctrl_auto - 1
is not the same value as
sizeof(ctrl_auto - 1)
because sizeof(x) is normally the same as sizeof(x - 1), unless sizeof
x and sizeof 1 are different.
Consider that is maybe should be:
if (len == (sizeof(ctrl_auto) - 1)) && strncmp(buf, ctrl_auto, len) == 0)

I a not sure what the correct answer is for this particular bit of
code, because I have not looked at it in detail,I just wanted to point
out that the brackets might be in the wrong place here.

James
