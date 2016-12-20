From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 0/3] PM / docs: linux/pm.h kerneldocs update and conversion of two documents to reST
Date: Tue, 20 Dec 2016 14:39:46 +0100
Message-ID: <3787531.gW0lbeikP7@aspire.rjw.lan>
References: <1812473.IRtThzhzgn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1812473.IRtThzhzgn@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Monday, December 19, 2016 09:40:20 PM Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> These two patches update kerneldoc comments in include/linux/pm.h ([1/2]) and
> convert Documentation/power/devices.txt to reST ([2/2], RFC).
> 
> Please have a look, especially at patch [2/2], and let me know what can be done
> in a better way.

Updated series follows.

Patch [1/3] makes more changes than the previous version (see the changelog for details).

Patch [2/3] adds a new document (types.rst) for the data type definitions and uses some
more proper markup (the :fille: markup for file names among other things).  Also the
"struct" keyword thing is now done differently.

Patch [3/3] is new and converts Documentation/power/notifiers.txt to reST (and
moves the doc to driver-api/pm/).

Thanks,
Rafael

