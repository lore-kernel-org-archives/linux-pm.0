From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Re: swsusp limits
Date: Tue, 09 Aug 2005 08:36:53 +1000
Message-ID: <1123540613.7296.2.camel@localhost>
References: <Pine.LNX.4.50.0508081248540.1704-100000@shark.he.net>
	<20050808220746.GA1821@elf.ucw.cz>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15734088046017192=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050808220746.GA1821@elf.ucw.cz>
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

--===============15734088046017192==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Tue, 2005-08-09 at 08:07, Pavel Machek wrote:
> > Is there an option or possibility of using a dedicated swap
> > partition for suspend to disk?
> > Or maybe there is no reason to think that this might help?
> 
> I don't see how it could help.

If it was turned on at the right time, it might not be used by other
things that could get swapped out by high memory usage and/or the memory
eating process.

> > If my application(s) causes lots of memory & swap space
> > to be used (over half of the total system RAM), is it correct
> > that it is likely to be useless to try to suspend to disk
> > while that app is running?
> 
> No, it should work okay, as long as you do not mlock() it. Just prepare
> big enough swap partition.

Will he even need to worry about the size of his swap partition? I
though swsusp discarded everything it could anyway. (Perhaps you could
add this question to the FAQ too).

Regards,

Nigel

> [I'll add your questions to FAQ...]
> 								Pavel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============15734088046017192==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15734088046017192==--
