From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 06/11] PM: Add user-space wake lock api.
Date: Fri, 30 Jan 2009 16:17:30 -0800
Message-ID: <d6200be20901301617i21a9a82cpefe1f00590fb0f89@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-6-git-send-email-arve@android.com>
	<1231896476-22445-7-git-send-email-arve@android.com>
	<200901301343.08604.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901301343.08604.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 30, 2009 at 4:43 AM, Uli Luckas <u.luckas@road.de> wrote:
> On Wednesday, 14. January 2009, Arve Hj=F8nnev=E5g wrote:
>> This adds /sys/power/wake_lock and /sys/power/wake_unlock.
>> Writing a string to wake_lock creates a wake lock the
>> first time is sees a string and locks it. Optionally, the
>> string can be followed by a timeout.
>> To unlock the wake lock, write the same string to wake_unlock.
> What happens if a process takes a lock and then dies?

The lock will be held until the process restarts and unlocks it. We
only use this interface directly from processes that are started (and
restarted) from init. Applications use the user space api which talks
to our system process. If an application dies the system process is
notified and (userspace) wakelocks are deleted.

> Instead of using sysfs, how about using a device for this purpose which t=
he
> caller has to keep open as long as they want to hold the lock.

If you want to use wakelocks directly from applications, that makes
sense, but I'm not sure we also want to remove this interface.

-- =

Arve Hj=F8nnev=E5g
