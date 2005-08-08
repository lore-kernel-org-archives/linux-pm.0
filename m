From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp limits
Date: Tue, 9 Aug 2005 00:07:47 +0200
Message-ID: <20050808220746.GA1821@elf.ucw.cz>
References: <Pine.LNX.4.50.0508081248540.1704-100000@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48719930476653461=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0508081248540.1704-100000@shark.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============48719930476653461==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Is there a maximum system RAM size that is supported by swsusp?

It should work okay with highmem.

> Does swsusp (to disk) use only one swap partition or can it use
> multiple swap partitions (aggregate them into one logical space)?

Only one swap partition, sorry.

> Is there an option or possibility of using a dedicated swap
> partition for suspend to disk?
> Or maybe there is no reason to think that this might help?

I don't see how it could help.

> If my application(s) causes lots of memory & swap space
> to be used (over half of the total system RAM), is it correct
> that it is likely to be useless to try to suspend to disk
> while that app is running?

No, it should work okay, as long as you do not mlock() it. Just prepare
big enough swap partition.

[I'll add your questions to FAQ...]
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============48719930476653461==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48719930476653461==--
