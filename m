From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Date: Sun, 22 Apr 2018 16:05:08 +0200
Message-ID: <20180422140508.GA21446@kroah.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 23, 2018 at 10:12:20AM +0000, Adam Thomson wrote:
> This commit adds code to handle requesting of PPS APDOs. Switching
> between standard PDOs and APDOs, and re-requesting an APDO to
> modify operating voltage/current will be triggered by an
> external call into TCPM.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/usb/typec/tcpm.c | 517 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/usb/pd.h   |   4 +-
>  include/linux/usb/tcpm.h |   1 +
>  3 files changed, 509 insertions(+), 13 deletions(-)

This patch adds build warnings to the tree, so I can't take it, sorry.
Please fix up and resend.

thanks,

greg k-h
