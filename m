From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: swsusp3: push image reading/writing into userspace
Date: Thu, 15 Sep 2005 17:16:21 +1000
Message-ID: <1126768581.3987.31.camel@localhost>
References: <20050914223206.GA2376@elf.ucw.cz>
	<1126749596.3987.5.camel@localhost> <20050915063753.GA2691@elf.ucw.cz>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============95747292790897043=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050915063753.GA2691@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============95747292790897043==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-09-15 at 16:37, Pavel Machek wrote:
> Hi!
> 
> > > Here's prototype code for swsusp3. It seems to work for me, but don't
> > > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > > it. This is just proof that it can be done, and that it can be done
> > > without excessive ammount of code.
> > 
> > No comments on the code sorry. Instead I want to ask, could you please
> > find a different name? swsusp3 is going to make people think that it's
> > Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> > know), how about using that name instead? At least then we'll clearly
> > differentiate the two implementations and you won't confuse/irritate
> > users.
> 
> swsusp2 can't be used, it is already "taken" by suspend2 (25000 hits
> on google). I was actually hoping that you would release suspend4
> (using swsusp3 infrastructure) :-).

You could reclaim it. There are 10 times as many hits (239,000) for
suspend2, and I've never wanted it to be called swsusp2 anyway :). As
for suspend4, at the moment, I'm not planning on ever progressing beyond
2.x.

> I guess I could call it "uswsusp".

u as in micro?

Regards,

Nigel

> 								Pavel
-- 



--===============95747292790897043==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============95747292790897043==--
