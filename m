From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] [RFC] ehci: Disable wake on overcurrent
 (WKOC_E) and disconnect (WKDISC_E)
Date: Tue, 27 Apr 2010 14:33:59 -0700
Message-ID: <20100427213359.GA29696__9713.26688672907$1272404213$gmane$org@kroah.com>
References: <Pine.LNX.4.44L0.1004271509450.1850-100000@iolanthe.rowland.org>
	<201004272246.51494.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201004272246.51494.linux@rainbow-software.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 27, 2010 at 10:46:48PM +0200, Ondrej Zary wrote:
> > Why would you want to change the jumper settings?  Host controllers are
> > _supposed_ to supply 5V power during system suspend.
> 
> Maybe because I don't want all my USB devices to be powered when the system is 
> turned off. I doubt that laptop in suspend-to-RAM (on battery) provides power 
> to USB ports.

On the contrary, it does.  Some of us use this mode to charge devices :)

thanks,

greg k-h
