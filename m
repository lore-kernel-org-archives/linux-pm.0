From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 8/9] Input: Block suspend while event queue
	is not empty.
Date: Sun, 25 Apr 2010 15:41:23 -0700
Message-ID: <j2id6200be21004251541z53ebce31rddb659680219c450__5444.65650241381$1272235642$gmane$org@mail.gmail.com>
References: <201004250430.31054.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1004251122230.25835-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1004251122230.25835-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Jiri Kosina <jkosina@suse.cz>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Tero Saarni <tero.saarni@gmail.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 25, 2010 at 8:29 AM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Sun, 25 Apr 2010, Rafael J. Wysocki wrote:
>
>> On Saturday 24 April 2010, Alan Stern wrote:
>> > On Fri, 23 Apr 2010, Arve Hj=F8nnev=E5g wrote:
>> >
>> > > On Fri, Apr 23, 2010 at 2:08 PM, Dmitry Torokhov
>> > > <dmitry.torokhov@gmail.com> wrote:
>> > > > On Friday 23 April 2010 01:56:25 pm Randy Dunlap wrote:
>> > > >> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
>> > > >> > Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker t=
hat will
>> > > >> > block suspend while the event queue is not empty. This allows u=
serspace
>> > > >> > code to process input events while the device appears to be asl=
eep.
>
>> > Is there some reason why this feature needs to be enabled by an
>> > ioctl? =A0Why not make this suspend blocker permanently enabled?
>>
>> The ioctl is there so that user space can use suspend blockers, which is
>> needed because only user space know that some activities are going to co=
ntinue
>> and therefore the system should not be suspended (like playing music "in=
 the
>> background").
>
> No, you're thinking of a different ioctl: SUSPEND_BLOCKER_IOCTL_BLOCK.
> This one (EVIOCSSUSPENDBLOCK) is present _only_ to enable one specific
> suspend blocker, which is activated when the input event queue is
> non-empty. =A0I don't see any reason why it shouldn't be enabled all the
> time.
>

Some user space processes keep input devices open that they don't
currently read from. The current android kernel use a wakelock with a
timeout limit the damage caused by this code, but not blocking suspend
at all by default will handle this case better. Also, not all input
devices are used for wakeup events, so there is no need to block
suspend when their event queue is not empty.

-- =

Arve Hj=F8nnev=E5g
