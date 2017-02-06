From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3 v2] PM / docs: linux/pm.h kerneldocs update and
 conversion of two docs to reST
Date: Mon, 6 Feb 2017 11:28:18 -0700
Message-ID: <20170206112818.3694cf04@lwn.net>
References: <1741856.1gu5vXgsff@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1741856.1gu5vXgsff@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Lukas Wunner <lukas@wunner.de>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 02 Feb 2017 01:30:08 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> This is a new (and hopefully final) iteration of the series of patches starting
> the conversion of power management driver API documentation.
> 
> Patch [1/3] updates kerneldoc comments in include/linux/pm.h (to make the
> documentation generated out of them look better), patch [2/3] converts
> Documentation/power/devices.txt to reST, and patch [3/3] does the same thing
> to Documentation/power/notifiers.txt (the new files go into the driver-api subdir
> and are hooked up to that manual).
> 
> Patch [1/3] has not been changed since the previous iteration.  Patch [2/3]
> addresses some comments from Lukas and patch [3/3] has been trivially
> rebased.
> 
> Please apply unless there are any objections.

Just applied them, thanks.

One thing I do notice is that, while you update the kerneldoc comments,
nothing in the associated documentation pulls them in.  That would be a
good future enhancement...:)

Thanks,

jon
