From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] PM: runtime: add might_sleep to PM runtime
	functions
Date: Sat, 23 Jul 2011 18:48:21 -0700
Message-ID: <CAMbhsRT36FsptMbHGtbY8xV=Lso3h-OY8cKc_LAtVHnKV+rm4w@mail.gmail.com>
References: <CAMbhsRTdQLd5GRew9GMx6O287k3O17SKE18jvK2k7oyZpOrZfg@mail.gmail.com>
	<Pine.LNX.4.44L0.1107232136490.26837-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1107232136490.26837-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 23, 2011 at 6:41 PM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Sat, 23 Jul 2011, Colin Cross wrote:
>
>> On Sat, Jul 23, 2011 at 3:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Saturday, July 23, 2011, Colin Cross wrote:
>> >> The list of functions that can be called in atomic context is
>> >> non-intuitive (pm_runtime_put_sync can not, but
>> >> pm_runtime_put_sync_suspend can, if pm_runtime_irq_safe has
>> >> been called?).
>> >
>> > However, this behavior is documented.
>> >
>> > Also, if you have a clean use case for calling rpm_idle() with interru=
pts
>> > off, it can be modified to work in analogy with rpm_suspend() in that =
respect.
>>
>> Yes, Kevin posted that patch in response to a bug that would never
>> have existed with this patch. =A0Even with Kevin's change, this patch
>> still detects drivers that are missing pm_runtime_irq_safe().
>
> I suggest that adding the annotations to __pm_runtime_idle(),
> __pm_runtime_suspend(), and __pm_runtime_resume() is entirely
> reasonable. =A0But the annotations to __pm_runtime_disable() and
> __pm_runtime_use_autosuspend() do seem unnecessary.

OK, I'll drop those.
