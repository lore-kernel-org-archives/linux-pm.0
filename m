From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: power/level and power/control
Date: Fri, 12 Mar 2010 10:08:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003121007400.1771-100000__40782.8556177721$1268406690$gmane$org@iolanthe.rowland.org>
References: <ac3eb2511003120304v39387563l95d2a9c6a00f3f5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <ac3eb2511003120304v39387563l95d2a9c6a00f3f5d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 12 Mar 2010, Kay Sievers wrote:

> > Shouldn't it suffice to extend usb_device namespace values in HAL
> > specification for runtime PM and once added let distribution
> > specific user space PM framework handle this.
> > http://people.redhat.com/davidz/hal-spec/hal-spec.html#device-properties-usb
> >
> > I guess the industry is moving towards DeviceKit, anyway that is just
> > implementation specific.
> 
> There is no HAL anymore, it's dead and no longer maintained. DeviceKit
> was only a temporary name, and does not exist as a project.
> 
> HAL is split into pieces, like udisks, upower, and along with udev,
> PulseAudio, NetworkManager, ConsoleKit, PolicyKit, ..., there are
> specialized daemons taking care of domain-specific tasks. There is
> nothing really where USB power management would really fit in today.

Is David Zeuthen still the person in charge of all this?  We should ask 
him.

Alan Stern
