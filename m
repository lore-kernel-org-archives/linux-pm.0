From: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [PATCH 1/2] Add some basic resume trace facilities
Date: Tue, 13 Jun 2006 15:25:42 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D01623F6F@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>, linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org

>-----Original Message-----
>From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Nigel
>Cunningham
>Sent: Tuesday, June 13, 2006 3:10 PM
>To: linux-pm@lists.osdl.org
>Cc: Linus Torvalds
>Subject: Re: [linux-pm] [PATCH 1/2] Add some basic resume trace
facilities
>
>Hi.
>
>On Wednesday 14 June 2006 07:35, Linus Torvalds wrote:
>> Considering that there isn't a lot of hw we can depend on during
>> resume, this is about as good as it gets.
>>
>> Use "#include <linux/resume-trace.h>", and then sprinkle
TRACE_RESUME(0)
>> commands liberally over the driver that you're trying to figure out
why
>> and where it hangs. Expect to waste a _lot_ of time, but at least
this
>> gives you _some_ chance to actually debug it, instead of just staring
at a
>> dead machine.
>>
>> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
>s/On laptop per child/One bdi2000 per computer/? I'll give it a try.

That thing has a lot of flash one could just use to dump the system log
too.

If you can spare a few blocks it's not too hard to write a low level
synchronous flash write code that works at panic time.  I did this to a
2.4.10 kernel a while back, and it was *very* useful for debugging
problems.

--mgross
