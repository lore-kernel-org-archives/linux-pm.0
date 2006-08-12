From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Sat, 12 Aug 2006 12:07:31 +0400
Message-ID: <acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
References: <44D8D40F.50005@mvista.com>
	<bb52214749a48f317fba09eb522537bb@nomadgs.com>
	<5da81756733c335565f969bab0c9b934@mvista.com>
	<26d93dc005e384544d9ea702baa4a4af@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <26d93dc005e384544d9ea702baa4a4af@nomadgs.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: linux-pm@lists.osdl.org, david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

> Yes, which is why Eugeny and I sent out the take 3 PowerOP patches.  A
> good discussion ensued and our updated patches are a result of that
> discussion.  If you disagree with our approach or think something is
> missing, give us some specific feedback.  Simply sending out a separate
> set of PowerOP patches is not joining in the current discussion.  It is
> confusing and probably turning people off to the ideas.   Is there
> something specific missing or wrong with the patches we submitted that
> required another set of patches to be developed?  By joining in the
> discussion, I mean that you should let us know this information.  If
> patches are your method for doing so, then at least provide a
> description of what your patches address that ours does not.  Right
> now, its just unclear why there are two different powerop patchsets.

May I disagree? Having an alternative implementation is never a bad
thing, unless the sides are unable to co-operate ;)
Let's try to compare implementations and their concepts, and benefit from b=
oth.

> Um,  I thought the powerop write up and  patches already sent out
> addressed the goals discussed so far.  We (everyone on the list) need
> to collaborate on the powerop effort.  Isolated development and
> attempting to discuss two separate implementations won't get us very
> far.

I would like to suggest both sides to think over what the main
differences of the concurring implementations are and share the
thoughts with this list. That should really be helpful to work out the
common solution.

> My goal is to get PowerOP into the mainline kernel.  If everyone
> submits a different powerop implementation for those boards, then
> people will see a fragmented concept that can not be generalized.  The
> possibility of Andrew and Linus accepting PowerOP will go from high to
> never.   Again, I don't see any reason for two separate development
> efforts and patchsets.  Please stop submitting separate patches and at
> least attempt to collaborate on the current PowerOP patchsets under
> discussion.

I wouldn't say so. I would just like to see both implementations
converging, but that is not to happen immediately. Anyway, this
implies that both authors pay more attention to the other
implementation.

Vitaly
