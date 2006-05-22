From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Ejecting/Powering off/ -> Turn off the device lamp.
Date: Mon, 22 May 2006 12:40:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0605221238290.5806-100000@iolanthe.rowland.org>
References: <4471E520.1090008@techmoninc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34921248770555824=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <4471E520.1090008@techmoninc.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andy Kennedy <akennedy@techmoninc.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============34921248770555824==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 22 May 2006, Andy Kennedy wrote:

> All,
> 
> I have done an extensive search on this issue and cannot find the answer 
> to my specific question.  Whereas I understand that an individual device 
> on a USB host (on board) cannot be "powered off" nor "ejected" I wonder 
> if the device can be sent a command from userspace to turn off it's LED 
> indicator lamp.  Most of the devices that I have seen, when the device 
> is no longer in use, goes into a blink cycle.
> 
> Is there a way to signal the device to stop the cycle and actually power 
> off the LED?

It's hard to answer that question without knowing what kind of device
you're talking about.  Some USB devices (like hubs) can be told to turn
off their indicators; most cannot.

Alan Stern


--===============34921248770555824==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34921248770555824==--
