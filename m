From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] PM / docs: linux/pm.h kerneldocs update and conversion of two docs to reST
Date: Fri, 06 Jan 2017 02:38:13 +0100
Message-ID: <17467778.bsRBpnPicc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Everyone,

I sent patches [1-2/3] previosly a couple of weeks ago and there have not been
any comments since then, so either they are fine by everybody or the timing
was particularly bad and no one had the time to look at them.  Admittedly, the
former is more attractive to me, so I'll assume that this is the case if there
are no comments still this time. :-)

Patch [1/3] updates kerneldoc comments in include/linux/pm.h (to make the
documentation generated out of them look better), patch [2/3] converts
Documentation/power/devices.txt to reST, and patch [3/3] does the same thing
to Documentation/power/notifiers.txt (the new files go into the driver-api subdir
and are hooked up to that manual).

If the conversions can be done in a better way (with not much more effort),
please let me know.

Thanks,
Rafael
