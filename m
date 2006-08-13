From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Sat, 12 Aug 2006 22:25:58 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD019C04DA@de01exm64.ds.mot.com>
References: <ea3ff079538ac1f02dd4c7ec48953146@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <ea3ff079538ac1f02dd4c7ec48953146@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>, Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org, david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

I'd say that David's recent note provides some useful information about
why his implementation is different. I don't mind seeing an alternate
implementation if there's a reason for it, but I have to say that it
would have been nice to have the exegesis with or before the patches.

scott

-----Original Message-----
From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Matthew Locke
Sent: Saturday, August 12, 2006 6:15 PM
To: Vitaly Wool
Cc: linux-pm@lists.osdl.org; david singleton
Subject: Re: [linux-pm] Dynanic On-The-Fly Operating points for PowerOP


On Aug 12, 2006, at 1:07 AM, Vitaly Wool wrote:
> May I disagree? Having an alternative implementation is never a bad =

> thing, unless the sides are unable to co-operate ;) Let's try to =

> compare implementations and their concepts, and benefit from both.

What are you disagreeing with?  Re-read my statement below.   I don't =

see the reason for another implementation.  Rather than guess,  I would
prefer that Dave tell us why he is submitting a different powerop
interface.  There must be something driving him to do so.

>> Is there
>> something specific missing or wrong with the patches we submitted =

>> that required another set of patches to be developed?  By joining in =

>> the discussion, I mean that you should let us know this information.

>> If patches are your method for doing so, then at least provide a =

>> description of what your patches address that ours does not.  Right =

>> now, its just unclear why there are two different powerop patchsets.
>>

Matt

_______________________________________________
linux-pm mailing list
linux-pm@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/linux-pm
