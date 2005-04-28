From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Power Management Policies
Date: Thu, 28 Apr 2005 20:59:59 +0200
Message-ID: <20050428185959.GA12495@elf.ucw.cz>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<200504271705.40068.david-b@pacbell.net>
	<20050428082313.GJ1906@elf.ucw.cz>
	<200504281016.44512.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75324603774316623=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504281016.44512.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============75324603774316623==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > sl-5500 has peripheral controller, but sl-5600 and newer should have a
> > host controller. [Unfortunately mine is 5500.]
> 
> I think you're wrong about all except possibly the very latest ones
> using pxa27x chips.  The pxa25x based products would need a separate
> controller chip to get host functionality.  I know for a fact that
> even the C-860 doesn't have one integrated; folk use that CF/IO card,
> with an sl811hs driver, if they crave a USB keyboard or flashdisk.

I searched web a bit, on amazon pages:

Sharp Zaurus SL-6000L Handheld
Other products by Sharp

Usually ships within 1-2 business days


3 used & new from $799.00



Technical data

    * Operating System: Embedded Linux with J2ME CDC Personal Profile
    * Display: 4 inch 640 x 480 CG Silicon transflective TFT
    * Wireless: Integrated 802.11 lb
    * Keyboard: 37-key QWERTY keyboard with slide cover
    * Memory: 64 MB SDRAM; 64 MB Flash
    * Expansion Slots: 1 Type II CF slot; 1 SD slot
    * Input/Output: USB 1.1 host connector mini Type-A, IR port, 2.5
                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Okay, that's strange. Mini conectors are only device-side, right?

If c-860 does not have usb, I was probably wrong (or confused by
something like above...)
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============75324603774316623==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============75324603774316623==--
