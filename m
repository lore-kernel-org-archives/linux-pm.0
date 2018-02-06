From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v4 1/7] typec: tcpm: Add PD Rev 3.0 definitions to PD
 header
Date: Tue, 6 Feb 2018 14:14:06 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C1519@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <ab71575c23391464262493ae353c098b268116a4.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130122134.GA14922@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.108]:14883 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751756AbeBFOOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Feb 2018 09:14:11 -0500
In-Reply-To: <20180130122134.GA14922@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On 30 January 2018 12:22, Heikki Krogerus wrote:

> On Tue, Jan 02, 2018 at 03:50:49PM +0000, Adam Thomson wrote:
> > This commit adds definitions for PD Rev 3.0 messages, including
> > APDO PPS and extended message support for TCPM.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>
> Just one nitpick. I noticed that you are exceeding the 80 character
> limit per line in several places in this series, and I many cases it
> does not look like splitting the line would make the code any less
> readable.
>
> But I don't think that is critical, so if there are no other comments:
>
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks for the Ack. The file, before I updated it, already had lines like this
for similar definitions. With that in mind I'd erred on the side of style (and
readability, at least in my opinion :)) rather than dropping onto new lines as
they weren't going over by a great deal. However if there's a desire for this to
change then I can update accordingly.
