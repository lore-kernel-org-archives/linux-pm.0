From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Mon, 3 May 2010 14:26:59 -0700
Message-ID: <m2yd6200be21005031426n87ea43a0k968fd5898ce0b873__12757.5019411326$1272922129$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005021755320.30701-100000@netrider.rowland.org>
	<201005031703.11448.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005031703.11448.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 3, 2010 at 8:03 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday 02 May 2010, Alan Stern wrote:
>> On Sun, 2 May 2010, Rafael J. Wysocki wrote:
>>
>> > Hmm. =A0It doesn't seem to be possible to create two different suspend=
 blockers
>> > using the same file handle. =A0So, what exactly is a process supposed =
to do to
>> > use two suspend blockers at the same time?
>>
>> Open the file twice, thereby obtaining two file handles.
>
> Well, that's what I thought.
>
> I must admit I'm not really comfortable with this interface. =A0IMO it wo=
uld
> be better if _open() created the suspend blocker giving it a name based on
> the name of the process that called it. =A0Something like
> "<process name>_<timestamp>" might work at first sight.
>
> Alternatively, "<process_name><number>", where <number> is 0 for the first
> suspend blocker created by the given process, 1 for the second one etc., =
also
> seems to be doable.

I think it is important to let user-space specify the name. If a
process uses multiple suspend blockers, it is impossible to tell what
each one is used for if they are automatically named.

-- =

Arve Hj=F8nnev=E5g
