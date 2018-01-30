From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 7/7] typec: tcpm: Add support for sink PPS related
 messages
Date: Tue, 30 Jan 2018 15:18:02 +0200
Message-ID: <20180130131802.GG14922@kuha.fi.intel.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <ec6635bd870084dbabf2f53b46ca3d0d5a0dd074.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46328 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbeA3NSU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jan 2018 08:18:20 -0500
Content-Disposition: inline
In-Reply-To: <ec6635bd870084dbabf2f53b46ca3d0d5a0dd074.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com

On Tue, Jan 02, 2018 at 03:50:55PM +0000, Adam Thomson wrote:
> This commit adds sink side support for Get_Status, Status,
> Get_PPS_Status and PPS_Status handling. As there's the
> potential for a partner to respond with Not_Supported
> handling of this message is also added. Sending of
> Not_Supported is added is added to handle messages
> received but not yet handled.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki
