From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] Fwd: USB suspending
Date: Fri, 5 Oct 2007 15:59:43 +0200
Message-ID: <200710051559.43771.oliver__13808.0670069487$1191592790$gmane$org@neukum.org>
References: <200710051551.24781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710051551.24781.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-usb-devel@lists.sourceforge.net
Cc: pm list <linux-pm@lists.linux-foundation.org>, Lukas Hejtmanek <xhejtman@ics.muni.cz>
List-Id: linux-pm@vger.kernel.org

Am Freitag 05 Oktober 2007 schrieb Rafael J. Wysocki:
> Hi,
> 
> Below is a Lukas' question related to USB suspend that I'm not able to answer.
> 
> Please help!
> 
> Greetings,
> Rafael
> 
> 
> ----------  Forwarded Message  ----------
> 
> Subject: USB suspending
> Date: Friday, 5 October 2007 14:54
> From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
> To: "Rafael J. Wysocki" <rjw@sisk.pl>
> 
> Hello,
> 
> I've noticed that while suspended in RAM USB ports are powered so any device
> connected to the port gets power. Can I turn off power of all USBs ports while
> suspending to RAM?

If you do that all devices on these ports will be disconnected.
If you still insist on doing so, it is done by a USB control request.
But power consumption on these ports is minimal for suspended devices,
so it is a bad idea.

	HTH
		Oliver
