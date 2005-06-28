From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Suspend "core": what to do now ?
Date: Tue, 28 Jun 2005 16:37:41 +1000
Message-ID: <1119940660.7513.24.camel@localhost>
References: <1119851395.5133.112.camel@gaston>
	<1119912918.30369.7.camel@localhost.localdomain>
	<1119916159.5133.145.camel@gaston> <1119931577.5133.189.camel@gaston>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============64495334222628542=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1119931577.5133.189.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adam Belay <abelay@novell.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============64495334222628542==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Tue, 2005-06-28 at 14:06, Benjamin Herrenschmidt wrote:
> I'm inclined to just trash all of that... but Nigel will have the same
> problem here, if I start moving the core of swsusp to arch code, he'll
> have to move the core of swsusp2 accordingly.

I have the problem that I have so little arch dependant code that it
seems silly to make the switch, but I also like the idea (as mentioned
on irc) of being able to switch between modes. (S3 for a while, then S4,
eg). To achieve something like that, it makes sense to have something
more generic, I think, that can handle these transitions. Then again,
maybe I'm just thinking of an extension to runtime PM :>

Whatever you do, I will have to work with it. I don't really see what
you're aiming at though, so I could do with a bit more brain dump if
you're willing.

Regards,

Nigel


--===============64495334222628542==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============64495334222628542==--
