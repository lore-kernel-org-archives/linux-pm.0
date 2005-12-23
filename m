From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 16:22:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512231619010.28577-100000@netrider.rowland.org>
References: <20051223172057.GA15357@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============84293803568222136=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051223172057.GA15357@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============84293803568222136==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 23 Dec 2005, Pavel Machek wrote:

> Well, if you can find some elegant solution in the core, I think thats
> the best way.
> 
> You could set system_state to "suspending" or something like that, and
> just if() out notifications in that case.

How about simply adding a call to try_to_freeze() somewhere inside 
kernel/kmod.c:____call_usermodehelper()?  That ought to do pretty much 
what I want, in theory.  The hotplug processes would get frozen before 
/sbin/hotplug is exec'ed.

I haven't actually tried it yet, so maybe there's a hidden gotcha.

Alan Stern


--===============84293803568222136==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============84293803568222136==--
