From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 15:04:05 +0200
Message-ID: <20050928130405.GB2118@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
	<1127855345.4802.13.camel@localhost>
	<20050927220110.GB2381@elf.ucw.cz>
	<1127863145.4802.40.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============026435605547927565=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1127863145.4802.40.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============026435605547927565==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> I guess there are three possible solutions:
> 1) Leave things as they are and say it is the user's problem if they
> make the state inconsistent.
> 2) Keep knowledge of the device states across the atomic restore and use
> that information in deciding what to do in device resume/powerup.
> 3) Make device drivers handle the situation properly without knowledge
> of what state the hardware is really in (or check the real state - where
> possible - and rely on that in deciding what to do).
> 
> 2 seems to me to make for the most reliable solution.

I actually like 3 most -- it does not need core changes.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============026435605547927565==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============026435605547927565==--
