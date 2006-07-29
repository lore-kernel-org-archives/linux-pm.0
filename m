From: david singleton <dsingleton@mvista.com>
Subject: Re: PowerOp Design and working patch
Date: Fri, 28 Jul 2006 22:12:26 -0700
Message-ID: <1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060728233837.GG2140@kroah.com>
	<c6333353f00bb7fd435ef518dc8cee21@mvista.com>
	<20060729004546.GA3917@kroah.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060729004546.GA3917@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


Greg,
	perhaps I need to back up a bit.  I wasn't submitting these patches
for inclusion into Linux.  I was presenting them to the people =

discussing
how power management might evolve in Linux.

	This patch is just a toy prototype to use as a strawman to discuss
how power management infrastructures in Linux might evolve to be more:
	=

	a) unified

and
	b) simplified for both kernel and user space.

	The Documentation/powerop.txt included in the powerop-core.patch
tries to describe what the patch is attempting to do and how it works.

David


On Jul 28, 2006, at 5:45 PM, Greg KH wrote:

> On Fri, Jul 28, 2006 at 05:38:11PM -0700, david singleton wrote:
>>
>> On Jul 28, 2006, at 4:38 PM, Greg KH wrote:
>>
>>> On Fri, Jul 28, 2006 at 03:31:41PM -0700, david singleton wrote:
>>>> Here is a patch that implements a version of the PowerOp concept.
>>>
>>> Any chance of breaking this up into logical patches that do one thing
>>> at
>>> a time so it can be reviewed better?
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>> Here's powerop-core.patch,  powerop-cpufreq.patch and
>> powerop-x86-centrino.patch.
>
> Um, no, that's not how kernel patches are submitted.  How about one per
> email, with a description of what they do, inline so we can quote them
> in a message (and actually read them in the original message...)
>
> See patches posted here by others as examples of what is expected, and
> see Documentation/SubmittingPatches for more details.
>
> thanks,
>
> greg k-h
