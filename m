From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Date: Sun, 22 Apr 2018 20:57:32 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E6AAD@SW-EX-MBX01.diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180422140508.GA21446@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180422140508.GA21446@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 22 April 2018 15:05, Greg Kroah-Hartman wrote:

> On Fri, Mar 23, 2018 at 10:12:20AM +0000, Adam Thomson wrote:
> > This commit adds code to handle requesting of PPS APDOs. Switching
> > between standard PDOs and APDOs, and re-requesting an APDO to
> > modify operating voltage/current will be triggered by an
> > external call into TCPM.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/usb/typec/tcpm.c | 517
> ++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/usb/pd.h   |   4 +-
> >  include/linux/usb/tcpm.h |   1 +
> >  3 files changed, 509 insertions(+), 13 deletions(-)
> 
> This patch adds build warnings to the tree, so I can't take it, sorry.
> Please fix up and resend.

No problem. Sorry for that. Will take a look and resolve the warnings.
