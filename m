From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Date: Mon, 5 Feb 2018 10:30:12 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C119E@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130132504.GH14922@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.114]:46042 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750949AbeBEKaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Feb 2018 05:30:16 -0500
In-Reply-To: <20180130132504.GH14922@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On 30 January 2018 13:25, Heikki Krogerus wrote:

> On Tue, Jan 02, 2018 at 03:50:48PM +0000, Adam Thomson wrote:
> > This patch set adds sink side support for the PPS feature introduced in the
> > USB PD 3.0 specification.
> >
> > The source PPS supply is represented using the Power Supply framework to provide
> > access and control APIs for dealing with it's operating voltage and current,
> > and switching between a standard PDO and PPS APDO operation. During standard
> PDO
> > operation the voltage and current is read-only, but for APDO PPS these are
> > writable as well to allow for control.
> >
> > It should be noted that the keepalive for PPS is not handled within TCPM. The
> > expectation is that the external user will be required to ensure re-requests
> > occur regularly to ensure PPS remains and the source does not hard reset.
> 
> Sorry for the late reply. I don't have any major problems with these
> other than with 6/7. The documentation should be for the psy class,
> not tcpm. I'm also not comfortable with the "select POWER_SUPPLY", but
> if Guenter does not think it's a problem, I'm fine with it. I guess we
> can always, for example, introduce stubs for the power_supply*
> functions, and drop the dependency later.
> 
> But as usual with tcpm.c, Guenter needs to give his ACK.
> 
> Oh yes, and Sebastian needs to ACK the power_supply changes or course.

No problem. Thanks for your time reviewing this. Not the smallest patch set so
appreciate the effort spent. Was travelling last week, but should now have a bit
of free time to take a proper look at your comments and get back to you with
some meaningful responses.
