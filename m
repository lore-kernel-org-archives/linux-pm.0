From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Date: Mon, 19 Mar 2018 10:39:24 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E1F2B@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180309173339.GA9837@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1D92FC@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1D92FC@SW-EX-MBX01.diasemi.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 12 March 2018 08:33, Adam Thomson wrote:

> On 09 March 2018 17:34, Greg Kroah-Hartman wrote:
> 
> > On Tue, Jan 02, 2018 at 03:50:48PM +0000, Adam Thomson wrote:
> > > This patch set adds sink side support for the PPS feature introduced in the
> > > USB PD 3.0 specification.
> > >
> > > The source PPS supply is represented using the Power Supply framework to
> provide
> > > access and control APIs for dealing with it's operating voltage and current,
> > > and switching between a standard PDO and PPS APDO operation. During standard
> > PDO
> > > operation the voltage and current is read-only, but for APDO PPS these are
> > > writable as well to allow for control.
> > >
> > > It should be noted that the keepalive for PPS is not handled within TCPM. The
> > > expectation is that the external user will be required to ensure re-requests
> > > occur regularly to ensure PPS remains and the source does not hard reset.
> >
> > I've applied the first 3 patches now.  Can you rebase and resend based
> > on the feedback so far?
> 
> That's great. Thanks. Need to also rebase based on the patch
> 'Revert "typec: tcpm: Only request matching pdos"' as this impacts the APDO
> selection logic. This is on my TODO list and will try and deal with it ASAP,
> hopefully this week.

One quick question. The patch 'Revert "typec: tcpm: Only request matching pdos"'
from Hans isn't on your next branch. Is that something that will get pulled in
soon? Need this as well as my updates you already pulled into your next branch
before I can resubmit. For now I cherry-picked that patch locally for testing,
but that's no good for submission.
