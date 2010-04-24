From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 8/9] Input: Block suspend while event queue
	is not empty.
Date: Fri, 23 Apr 2010 22:02:50 -0700
Message-ID: <z2wd6200be21004232202me5d59908y25bf9523fd62edce__48516.8727850125$1272085489$gmane$org@mail.gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-9-git-send-email-arve@android.com>
	<20100423135625.1e12d005.randy.dunlap@oracle.com>
	<201004231408.15885.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004231408.15885.dmitry.torokhov@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-pm@lists.linux-foundation.org, Tero Saarni <tero.saarni@gmail.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 23, 2010 at 2:08 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Friday 23 April 2010 01:56:25 pm Randy Dunlap wrote:
>> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
>> > Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that will
>> > block suspend while the event queue is not empty. This allows userspace
>> > code to process input events while the device appears to be asleep.
>>
>> All new ioctls need to be added to Documentation/ioctl/ioctl-number.txt,
>> please.
>
> I do not see the reason for it to be in the kernel still. Have a process
> that listens to all input devices (or subset of them), once events stop
> coming initiate suspend.
>

I think the document added by the first patch explains this. The
solution you propose above will ignore a wakeup key pressed right
after user space decides to initiate suspend.

-- =

Arve Hj=F8nnev=E5g
