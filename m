From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/2] workqueues: export keventd_wq
Date: Thu, 29 Apr 2010 22:39:02 -0700
Message-ID: <t2gd6200be21004292239r582b8a43l2409491b8d32ef1b@mail.gmail.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<20100428194028.GA16389@redhat.com> <4BD89922.1040306@kernel.org>
	<201004282308.10751.rjw@sisk.pl> <20100429185851.GA13862@redhat.com>
	<20100429194447.GA17280@redhat.com>
	<20100429194545.GC17280@redhat.com> <4BDA67C1.7050709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BDA67C1.7050709@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 29, 2010 at 10:16 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 04/29/2010 09:45 PM, Oleg Nesterov wrote:
>> -static struct workqueue_struct *keventd_wq __read_mostly;
>> +struct workqueue_struct *keventd_wq __read_mostly;
>> +EXPORT_SYMBOL(keventd_wq);
>
> Umm... does it have to be EXPORTed? =A0Suspend block API can't be built
> as a module, right?

The suspend block api cannot be built as a module, but if
schedule_suspend_blocking_work will just call
queue_suspend_blocking_work(keventd_wq, work) it may as well be an
inline function which would require the export.

-- =

Arve Hj=F8nnev=E5g
