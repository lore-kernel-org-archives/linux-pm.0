From: David Brownell <david-b@pacbell.net>
Subject: Re: what can we do with frozen processes (or: calling
	sync with	processes frozen)
Date: Tue, 20 Mar 2007 14:14:08 -0700
Message-ID: <200703201414.08589.david-b@pacbell.net>
References: <1174173718.13027.0.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174173718.13027.0.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Saturday 17 March 2007 4:21 pm, Johannes Berg wrote:
> The real thing we should be doing is think about a whole range of things
> you can do in the kernel and then think about whether they should be
> allowed to be done in the various stages. =


ISTR making this point before.  Defining "stages" will be tricky too;
the early boot stuff (initramfs running programs while drivers init)
will be slippery, and the other key transitions -- suspend, resume,
shutdown, kexec -- aren't much better.

Plus, the "freezer" thing always seemed to me like a bit of a punt;
as in your XFS example, there are tasks that should be able to do
suspend related work before freezing random stuff, and likewise
afterward.  And I'm not sure that anyone pushing on this issue won't
find arch-specific differences...

Anyway, I agree with the point of yours which I quioted above.  :)

- dave
