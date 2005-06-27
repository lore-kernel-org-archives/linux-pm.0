From: Adam Belay <abelay@novell.com>
Subject: Re: Suspend "core": what to do now ?
Date: Mon, 27 Jun 2005 18:55:18 -0400
Message-ID: <1119912918.30369.7.camel@localhost.localdomain>
References: <1119851395.5133.112.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============094122294239407989=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1119851395.5133.112.camel@gaston>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============094122294239407989==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-06-27 at 15:49 +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> So I'm still sitting on that rewrite of the pmac suspend code including
> suspend to disk consolidation etc... that I would really like to get
> upstream. However, I'm still having a problem:
> 
>  - I'm still adding all those callbacks to pm_ops, Patrick wants to get
> the stuff out of the core, which I agree, but I don't feel like "fixing"
> x86 neither :) Pavel wants to keep the existing stuff.

I'd like to move it out of the core and use the pm functions as a
library.

> 
>  - If I keep my callbacks addition, we need to consolidate
> kernel/power/disk.c with kernel/power/main.c. I need all callbacks in
> both cases. The current inconsistency makes little sense.
> 
>  - I want that in 2.6.13 final, so please, let's decide something :)
> 
> Ben.

I'm familiar with the ACPI code.  If you'd like, I could work on the x86
pm_ops.

Let's discuss how we would change the existing PM code...

I was thinking each arch could provide a table of system power states
with an ->enter() function for each.  We would then show the names of
these states in "/sys/power/state", and the user could select one.  Did
you have something else in mind?

Thanks,
Adam



--===============094122294239407989==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============094122294239407989==--
