From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: pm_message_t becoming struct
Date: Fri, 25 Mar 2005 02:56:08 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503250223490.28664-100000@monsoon.he.net>
References: <20050325101149.GA1301@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============80624085546651791=="
In-Reply-To: <20050325101149.GA1301-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============80624085546651791==
Content-Type: TEXT/PLAIN; charset=US-ASCII


[cc list snipped ]

On Fri, 25 Mar 2005, Pavel Machek wrote:

> Hi!
>
> pm_message_t is becoming typedefed into struct with single field,
> "event" real soon now. If you do anything that wants to look inside
> pm_message_t, please base it on this patch.
>
> [Patrick and David would like to pass struct pm_message * instead of
> pm_message_t, but that just does not fly. Original code passed u32
> there (ouch), and it is not easy to replace u32 with struct pm_message
> * and not breaking the whole tree. Plus you do not get enough
> typechecking that way.]

There is significant disagreement about the interface that this patch
proposes from a number of people. About 12 hours ago, Pavel agreed that he
would not try to push this patch upstream until others had a chance to
come up with an alternative, more palatable interface. That seems to be in
direct conflict with this email.

Pavel, please think about the situation. Just because you think something
is a good idea and want the patch to go in doesn't mean that everyone else
does. You must accept the fact that people will disagree with you and that
some people may want an alternative interface.

I am willing to work with you, and I even volunteered to audit and fix up
all of the drivers. But, undermining that effort by back-peddling on what
you said and posting a patch in direct conflict with earlier agreement
borders on dishonesty and is frankly quite rude.

Saying 1 thing and doing another is counter-productive. It prolongs the
development process and brings to the arena feelings of frustration and
futility. Ideally, we should all try to minimize those, both in ourselves
and in each other.

There have been a lot of egos flying on this list. Everyone has an idea of
exactly how things should be done, and many people seem to imply that they
cannot be wrong. Even though you may not be thinking that, it may very
well come across that way. I've been guilty of it in the past, but I've
been making a very concerted effort to NOT be so arrogant, to come to
terms with and understand everything that people are saying, as well as
get back into being a full-time kernel developer.

We've been doing this for too long to have the flamewars burn out the
motivation once again. We have things to gain from listening to and
working with each other. Please, let's get this done.

Thanks,


	Pat

--===============80624085546651791==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============80624085546651791==--
