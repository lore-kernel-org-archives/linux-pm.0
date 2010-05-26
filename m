From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Wed, 26 May 2010 03:47:27 -0700
Message-ID: <AANLkTimTnzK1ByG2bE2gGjINxD_Pbvez7PFHo7Kzo9yk__11078.5322417089$1274870993$gmane$org@mail.gmail.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<1274482015-30899-2-git-send-email-arve@android.com>
	<1274482015-30899-3-git-send-email-arve@android.com>
	<1274863428.5882.4860.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274863428.5882.4860.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/5/26 Peter Zijlstra <peterz@infradead.org>:
> On Fri, 2010-05-21 at 15:46 -0700, Arve Hj=F8nnev=E5g wrote:
>> +To create a suspend blocker from user space, open the suspend_blocker
>> special
>> +device file:
>> +
>> + =A0 =A0fd =3D open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
>> +
>> +then optionally call:
>> +
>> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_SET_NAME(strlen(name)), name);
>> +
>> +To activate the suspend blocker call:
>> +
>> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_BLOCK);
>> +
>> +To deactivate it call:
>> +
>> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_UNBLOCK);
>> +
>> +To destroy the suspend blocker, close the device:
>> +
>> + =A0 =A0close(fd);
>
> Urgh, please let the open() be BLOCK, the close() be UNBLOCK, and keep
> the SET_NAME thing if you really care.
>

That would be very inefficient.

-- =

Arve Hj=F8nnev=E5g
