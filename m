From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp3: push image reading/writing into userspace
Date: Thu, 15 Sep 2005 08:37:53 +0200
Message-ID: <20050915063753.GA2691@elf.ucw.cz>
References: <20050914223206.GA2376@elf.ucw.cz>
	<1126749596.3987.5.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============61060275449173806=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1126749596.3987.5.camel@localhost>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============61060275449173806==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Here's prototype code for swsusp3. It seems to work for me, but don't
> > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > it. This is just proof that it can be done, and that it can be done
> > without excessive ammount of code.
> 
> No comments on the code sorry. Instead I want to ask, could you please
> find a different name? swsusp3 is going to make people think that it's
> Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> know), how about using that name instead? At least then we'll clearly
> differentiate the two implementations and you won't confuse/irritate
> users.

swsusp2 can't be used, it is already "taken" by suspend2 (25000 hits
on google). I was actually hoping that you would release suspend4
(using swsusp3 infrastructure) :-).

I guess I could call it "uswsusp".

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============61060275449173806==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============61060275449173806==--
