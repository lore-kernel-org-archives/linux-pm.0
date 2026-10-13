Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A2539786
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922884; cv=pass; b=mHHO5jWAMdibHe2HEBrVgstffr8OjX0w27jm4aDL0NpxT5OvbbnyVZmQ0dejkMNToJ1z8ZDBgMNdjFioqeaESHATHmmnQDagKqzRPxT3edJEe/WPleH3Zh+sK5ypLab7wDOlQ21fDnNccQQUmNlloanHvnHvVzsVR1AubfSSRW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922884; c=relaxed/simple;
	bh=xxOvf721KgqJqT5Yjw9s9kJ3wImugFlnKAyCSgeC05M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pC4KZTGOsJIsgv+HyRJwMIRfiDmIen6DMpzoYrDUL06ImeImz3xe2yxb1aLriIPD5UGK9evjDFtFkQzHXLRsswBy7WDQhGbAJQwlxOrjYJbuhrzm1SsJjj0tZU1edqAHftSunffDq2dEiY2J7mdw/hxCK7AaUBMSIj8/mn4Ro9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npsiBw9k; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npsiBw9k"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5337fa12431so961761cf.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791922881; cv=none;
        d=google.com; s=arc-20260327;
        b=jHAY9SqsRrhmMkQ8nosRzRaHYyGp88DLS/Y/DuWZlojpSe+RsH/sf1n+qcjwxN19nr
         tULLFv9/Of+Iu+a1YJ/GYEjAtQH+EDVIsMFtoNJB3Da6Q/Xgn4HHVBp1gZ50emV+NSW3
         6UGtlOzj+tt/PzBV6Dm6gJmOP5o2QgUtkUO3ZEar4J9rAMd59EZnOw83GgD0VFxi8KZU
         0p+H4mqaNkjJeTPH3sBO7RTmvAddTFJfJybwXqMG2pboriU52lE7xu24M9MECW7pjbDd
         FQOMpof/lWZV96LINfeFp+SKXkRF5HeIb8AKfqtrnA2hfZMQJfqliUZwpikyLPmcTVkK
         80yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Uu3Iqv0t79GTDrfZYBvAaVsbzV6bjgjtd2RimZpM59Y=;
        fh=FBF2VN/Lb4w6Ta9cvmY5kYaF/i/RwEdHYzjRSihNl+4=;
        b=mv+paHafYhPMeB/pAs2DZqKsvnFTzoXUHNaT10vGnKM5tWBg950gy3/KMamvRqSfzi
         kpakTZYh3kn1BRjJzGwjRaYWL5Kbsak19BFdrmXjZQ3ZAxPjWLnwvMceaa7euSTjH7Ov
         ObFoqqQta/IXOGFdID/4HSt7D8MATnhTAcaTQPsKWdEVVIEuwfqKuOh4i464XffkXrih
         i/KPlb1QAQduCSsNb6F2TljKyqrf/jVYDBJk8RIKsBq3crIInsrluqajri5ScEh0hgnN
         vI5nbYojnOP8dgpEddgkWkWppXT3U8+CYDATvCUgJbMm8dMXsL/qnciW/43RmyD5+aOa
         mHvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791922881; x=1792527681; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uu3Iqv0t79GTDrfZYBvAaVsbzV6bjgjtd2RimZpM59Y=;
        b=npsiBw9k6H5bnEeipVCbpJqWsX/sV0UuP0Gu5rthcuO1eUgYFm208blNEcrdUUTz6v
         xB3qL9Cw2qFL/ygJsUHVeZmGCpoP2XWgOmyP/jz71AKqWZnIvm4ETE89LaTZN9wiOKEA
         XwAEk+rx/k+2RFIUAiiNvvxPqMCE5Hzc2hZikrP4GencDCsoyoJj3Fjx+XtXHLJORjOo
         N8+D2APBi8caXoxATB9/DNNrpxJiZE2XS/AUG2vfajMS/+Tr0yu7JeNtX8VkcZqabseq
         6h4R8goqgRXarjagdRa9g27qZ3LpedVOCd5Qt2fQ0dnnCoQAlImIVt812kxUf4ejNa/5
         TeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922881; x=1792527681;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Uu3Iqv0t79GTDrfZYBvAaVsbzV6bjgjtd2RimZpM59Y=;
        b=vfCZtGgD+Syy65oMSSnLk8kRlwsd+1OnrwStXR3H+yZqO05BN91RFt5RYut9w9lnQa
         UwuOBfhTokFXo54rYFkr58MKsSFN+EHHNqu/Wj3LagXXlvlYA1wSnqLgSNzZFkAq4Eoh
         JzVoju6jN0Qa3ciqIhwvJKQcmJInnqOPvcWqXzBTPdXdPy//nrQ5f9ewyc6tYEabk5+J
         wHAmUOlzoe3Uj5T1dqDQkC7RixAmfEkWrc/OhR6XLfkMjj4g8K8qaVQCeMq6C2ZnZSC+
         UBRs8u0xxgjqs/gJDnky6K4VkG9dMWbq8y3Lfp5Ij38meaO1OJmFNvba5FgdGb3rGw8e
         eVHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt40QjhzHjW9Q9N8g7zjuBfrRH3AKpr7f8o8Sw615qC3G/En8EFOp0UoBL/qqB8LG/hxzcO9mMFQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzTxzJtftz5gZz23Zk44ubIkBMDuyIqSvImqF1RknTEEZD7I4R
	DoCH0AoANjfMuc8ZW4alPqw5VloUvf7laFgScushf8DJo+7JSmFKLUcOa0ydfFdXZdc84mYMtSp
	GB2l4h38zh3njiKzpP2PA7DWuqWX/1pnBjZCaNYye
X-Gm-Gg: AYBFou0oBDGKkUMqq2DwjSf2cvX4pYOkL0/FNDddhhEENTT++fb8/7Yn6lOEUBuHFmL
	nhAgdD7ohQOEkpWFXmX6eVznYGfzEblsFLC+FEJwvNEh9EDJDgyNi/7WQ3xe/0mAH28IO76XSOH
	igdDf3UH1Qeln0GvLJosgnioKRhByMuQxAUXYKVaNkMoor5bzoDPE6Bn7yjw9aDg9I9bqo6ozNw
	zJC+6PXDHmiuYvEiQ8GeZVBNKLnhBihYs2rOVXbfQ/qavJ+ZoiKvPp1Vm0Rytdbe2nNbdCy7qTJ
	sZPLFK2KbTIGNrQ1BkS/kLRZIOBn0eFMi25yEHhTD4ky4EqaGgTqY+PBBn/YbiU9lkyA7PE6V/j
	Bvh1HVZi8E9rwaY+AJNAwr4uH
X-Received: by 2002:a05:622a:1ba0:b0:534:313:9b4e with SMTP id
 d75a77b69052e-535b321298dmr57512211cf.5.1791922880608; Tue, 13 Oct 2026
 13:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sadrul Chowdhury <sadrul@google.com>
Date: Tue, 13 Oct 2026 16:21:08 -0400
X-Gm-Features: AclHuK9Vyag4IawcrZG5-4LpkcYucq7mjmH0zXviiwtdCJ8nVZ-d17BCJwjshGc
Message-ID: <CAKgcGXh-qG4LD70wSJMtfadXk+a9XaayfwtzGe3F0LbekYMOmw@mail.gmail.com>
Subject: [RESEND] Re: [PATCH 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	John Stultz <jstultz@google.com>
Content-Type: multipart/mixed; boundary="000000000000c552f3065dbe8eaa"

--000000000000c552f3065dbe8eaa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:21=E2=80=AFAM Sadrul Chowdhury <sadrul@google.com=
> wrote:
>
> On Wed, Sep 23, 2026 at 7:24=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 22-09-26 21:15:58, Sadrul Chowdhury wrote:
> > > During system suspend (freeze_processes) and resume (thaw_processes),
> > > threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> > > try_to_freeze_tasks() executes, it must wake up every sleeping thread
> > > with a synthetic signal so the thread can schedule, run try_to_freeze=
(),
> > > enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes th=
em
> > > all up simultaneously, only for each thread to re-enter ep_poll(),
> > > observe no ready I/O events, and call schedule() to go back to sleep.
> > >
> > > On systems with numerous event-driven daemons (where hundreds of
> > > threads idle in event loops), this causes a large wakeup stampede and
> > > thousands of redundant context switches per suspend/resume cycle.
> > >
> > > An earlier attempt to make epoll_wait() freezable in commit 1c441e921=
201
> > > ("epoll: use freezable blocking call") was reverted in commit
> > > c511851de162 ("Revert "epoll: use freezable blocking call"") due to
> > > reports of userspace corruption (Bugzilla #61781). Under the legacy
> > > freezer design, freezable tasks could wake up prematurely while
> > > hardware and peripheral drivers were still suspended.
> > >
> > > With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sch=
ed:
> > > Rewrite core freezer logic")), the legacy fake-signal mechanism was
> > > replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
> > > are safely frozen in-place without waking them up, and the scheduler
> > > guarantees they cannot be woken until thaw_processes() explicitly cle=
ars
> > > the frozen state.
> > >
> > > Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
> > > ARM64 test device demonstrate that combining this with freezable
> > > select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 m=
s
> > > mean at fixed CPU frequency) and reduces context switches during
> > > freeze/thaw by 87%.
> > >
> > > Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
> >
> > With similar caveat as on patch 2/2 feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
>
> Thank you for the review!
>
> Regards,
> Sadrul
>
> >                                                                 Honza
> >
> > > ---
> > >  fs/eventpoll.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index 6cbef8b4c2e0..35992f6457bf 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -39,6 +39,7 @@
> > >  #include <linux/rculist.h>
> > >  #include <linux/capability.h>
> > >  #include <net/busy_poll.h>
> > > +#include <linux/freezer.h>
> > >
> > >  #include <trace/hooks/fs.h>
> > >
> > > @@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct=
 epoll_event __user *events,
> > >                * the same lock on wakeup ep_poll_callback() side, so =
it
> > >                * is safe to avoid an explicit barrier.
> > >                */
> > > -             __set_current_state(TASK_INTERRUPTIBLE);
> > > +             __set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE=
);
> > >
> > >               /*
> > >                * Do the final check under the lock. ep_start/done_sca=
n()
> > > --
> > > 2.55.0.1082.g2b9226bbc0-goog
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR

--000000000000c552f3065dbe8eaa
Content-Type: application/x-patch; 
	name="0001-fs-epoll-mark-epoll_wait-tasks-TASK_FREEZABLE.patch"
Content-Disposition: attachment; 
	filename="0001-fs-epoll-mark-epoll_wait-tasks-TASK_FREEZABLE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv74e4k40>
X-Attachment-Id: f_mv74e4k40

RnJvbSA1Y2FiZTkyNzg0NTM1ZDhjZDVjYzlkNGI3NmQxODRmMzUzMzg0OGIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWRydWwgQ2hvd2RodXJ5IDxzYWRydWxAZ29vZ2xlLmNvbT4K
RGF0ZTogVHVlLCAxMyBPY3QgMjAyNiAyMDowODozNCArMDAwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBmcy9lcG9sbDogbWFyayBlcG9sbF93YWl0IHRhc2tzIFRBU0tfRlJFRVpBQkxFCgpEdXJpbmcg
c3lzdGVtIHN1c3BlbmQgKGZyZWV6ZV9wcm9jZXNzZXMpIGFuZCByZXN1bWUgKHRoYXdfcHJvY2Vz
c2VzKSwKdGhyZWFkcyBibG9ja2VkIGluIGVwb2xsX3dhaXQoKSBzbGVlcCBpbiBUQVNLX0lOVEVS
UlVQVElCTEUuIFdoZW4KdHJ5X3RvX2ZyZWV6ZV90YXNrcygpIGV4ZWN1dGVzLCBpdCBtdXN0IHdh
a2UgdXAgZXZlcnkgc2xlZXBpbmcgdGhyZWFkCndpdGggYSBzeW50aGV0aWMgc2lnbmFsIHNvIHRo
ZSB0aHJlYWQgY2FuIHNjaGVkdWxlLCBydW4gdHJ5X3RvX2ZyZWV6ZSgpLAplbnRlciBUQVNLX0ZS
T1pFTiwgYW5kIHNsZWVwIGFnYWluLiBVcG9uIHJlc3VtZSwgdGhlIGZyZWV6ZXIgd2FrZXMgdGhl
bQphbGwgdXAgc2ltdWx0YW5lb3VzbHksIG9ubHkgZm9yIGVhY2ggdGhyZWFkIHRvIHJlLWVudGVy
IGVwX3BvbGwoKSwKb2JzZXJ2ZSBubyByZWFkeSBJL08gZXZlbnRzLCBhbmQgY2FsbCBzY2hlZHVs
ZSgpIHRvIGdvIGJhY2sgdG8gc2xlZXAuCgpPbiBzeXN0ZW1zIHdpdGggbnVtZXJvdXMgZXZlbnQt
ZHJpdmVuIGRhZW1vbnMgKHdoZXJlIGh1bmRyZWRzIG9mCnRocmVhZHMgaWRsZSBpbiBldmVudCBs
b29wcyksIHRoaXMgY2F1c2VzIGEgbGFyZ2Ugd2FrZXVwIHN0YW1wZWRlIGFuZAp0aG91c2FuZHMg
b2YgcmVkdW5kYW50IGNvbnRleHQgc3dpdGNoZXMgcGVyIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLgoK
QW4gZWFybGllciBhdHRlbXB0IHRvIG1ha2UgZXBvbGxfd2FpdCgpIGZyZWV6YWJsZSBpbiBjb21t
aXQgMWM0NDFlOTIxMjAxCigiZXBvbGw6IHVzZSBmcmVlemFibGUgYmxvY2tpbmcgY2FsbCIpIHdh
cyByZXZlcnRlZCBpbiBjb21taXQKYzUxMTg1MWRlMTYyICgiUmV2ZXJ0ICJlcG9sbDogdXNlIGZy
ZWV6YWJsZSBibG9ja2luZyBjYWxsIiIpIGR1ZSB0bwpyZXBvcnRzIG9mIHVzZXJzcGFjZSBjb3Jy
dXB0aW9uIChCdWd6aWxsYSAjNjE3ODEpLiBVbmRlciB0aGUgbGVnYWN5CmZyZWV6ZXIgZGVzaWdu
LCBmcmVlemFibGUgdGFza3MgY291bGQgd2FrZSB1cCBwcmVtYXR1cmVseSB3aGlsZQpoYXJkd2Fy
ZSBhbmQgcGVyaXBoZXJhbCBkcml2ZXJzIHdlcmUgc3RpbGwgc3VzcGVuZGVkLgoKV2l0aCB0aGUg
MjAyMiBjb3JlIGZyZWV6ZXIgcmV3cml0ZSAoY29tbWl0IGY1ZDM5YjAyMDgwOSAoImZyZWV6ZXIs
c2NoZWQ6ClJld3JpdGUgY29yZSBmcmVlemVyIGxvZ2ljIikpLCB0aGUgbGVnYWN5IGZha2Utc2ln
bmFsIG1lY2hhbmlzbSB3YXMKcmVwbGFjZWQgd2l0aCB0aGUgVEFTS19GUk9aRU4gc3RhdGUuIFRh
c2tzIHNsZWVwaW5nIGluIFRBU0tfRlJFRVpBQkxFCmFyZSBzYWZlbHkgZnJvemVuIGluLXBsYWNl
IHdpdGhvdXQgd2FraW5nIHRoZW0gdXAsIGFuZCB0aGUgc2NoZWR1bGVyCmd1YXJhbnRlZXMgdGhl
eSBjYW5ub3QgYmUgd29rZW4gdW50aWwgdGhhd19wcm9jZXNzZXMoKSBleHBsaWNpdGx5IGNsZWFy
cwp0aGUgZnJvemVuIHN0YXRlLgoKTWFyayBzbGVlcGluZyB0YXNrcyBpbiBlcF9wb2xsKCkgYXMg
VEFTS19GUkVFWkFCTEUuIEJlbmNobWFya3Mgb24gYW4KQVJNNjQgdGVzdCBkZXZpY2UgZGVtb25z
dHJhdGUgdGhhdCBjb21iaW5pbmcgdGhpcyB3aXRoIGZyZWV6YWJsZQpzZWxlY3QvcG9sbCByZWR1
Y2VzIHRoYXcgbGF0ZW5jeSBieSA2MyUgKGZyb20gMjAuNjQgbXMgZG93biB0byA3LjU1IG1zCm1l
YW4gYXQgZml4ZWQgQ1BVIGZyZXF1ZW5jeSkgYW5kIHJlZHVjZXMgY29udGV4dCBzd2l0Y2hlcyBk
dXJpbmcKZnJlZXplL3RoYXcgYnkgODclLgoKUmV2aWV3ZWQtYnk6IEphbiBLYXJhIDxqYWNrQHN1
c2UuY3o+ClNpZ25lZC1vZmYtYnk6IFNhZHJ1bCBDaG93ZGh1cnkgPHNhZHJ1bEBnb29nbGUuY29t
PgotLS0KIGZzL2V2ZW50cG9sbC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9ldmVudHBvbGwuYyBiL2ZzL2V2
ZW50cG9sbC5jCmluZGV4IDZjYmVmOGI0YzJlMC4uMzU5OTJmNjQ1N2JmIDEwMDY0NAotLS0gYS9m
cy9ldmVudHBvbGwuYworKysgYi9mcy9ldmVudHBvbGwuYwpAQCAtMzksNiArMzksNyBAQAogI2lu
Y2x1ZGUgPGxpbnV4L3JjdWxpc3QuaD4KICNpbmNsdWRlIDxsaW51eC9jYXBhYmlsaXR5Lmg+CiAj
aW5jbHVkZSA8bmV0L2J1c3lfcG9sbC5oPgorI2luY2x1ZGUgPGxpbnV4L2ZyZWV6ZXIuaD4KIAog
I2luY2x1ZGUgPHRyYWNlL2hvb2tzL2ZzLmg+CiAKQEAgLTE5ODcsNyArMTk4OCw3IEBAIHN0YXRp
YyBpbnQgZXBfcG9sbChzdHJ1Y3QgZXZlbnRwb2xsICplcCwgc3RydWN0IGVwb2xsX2V2ZW50IF9f
dXNlciAqZXZlbnRzLAogCQkgKiB0aGUgc2FtZSBsb2NrIG9uIHdha2V1cCBlcF9wb2xsX2NhbGxi
YWNrKCkgc2lkZSwgc28gaXQKIAkJICogaXMgc2FmZSB0byBhdm9pZCBhbiBleHBsaWNpdCBiYXJy
aWVyLgogCQkgKi8KLQkJX19zZXRfY3VycmVudF9zdGF0ZShUQVNLX0lOVEVSUlVQVElCTEUpOwor
CQlfX3NldF9jdXJyZW50X3N0YXRlKFRBU0tfSU5URVJSVVBUSUJMRSB8IFRBU0tfRlJFRVpBQkxF
KTsKIAogCQkvKgogCQkgKiBEbyB0aGUgZmluYWwgY2hlY2sgdW5kZXIgdGhlIGxvY2suIGVwX3N0
YXJ0L2RvbmVfc2NhbigpCi0tIAoyLjU2LjAuMzg1LmdkM2FjYjkwZWY4LWdvb2cKCg==
--000000000000c552f3065dbe8eaa
Content-Type: application/x-patch; 
	name="0002-fs-select-mark-select-and-poll-tasks-TASK_FREEZABLE.patch"
Content-Disposition: attachment; 
	filename="0002-fs-select-mark-select-and-poll-tasks-TASK_FREEZABLE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv74e4le1>
X-Attachment-Id: f_mv74e4le1

RnJvbSAyM2IwOTNmMGY5ZjI2NmE4MGQzNjcyMjdhOGVmY2U5OTUzZDkwYTdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYWRydWwgQ2hvd2RodXJ5IDxzYWRydWxAZ29vZ2xlLmNvbT4K
RGF0ZTogVHVlLCAxMyBPY3QgMjAyNiAyMDowODozNSArMDAwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBmcy9zZWxlY3Q6IG1hcmsgc2VsZWN0IGFuZCBwb2xsIHRhc2tzIFRBU0tfRlJFRVpBQkxFCgpT
aW1pbGFyIHRvIGVwb2xsX3dhaXQoKSwgdGhyZWFkcyBzbGVlcGluZyBpbiBkb19zZWxlY3QoKSBh
bmQgZG9fcG9sbCgpCnNsZWVwIGluIFRBU0tfSU5URVJSVVBUSUJMRSB2aWEgcG9sbF9zY2hlZHVs
ZV90aW1lb3V0KCkuIER1cmluZyBzeXN0ZW0Kc3VzcGVuZCBhbmQgcmVzdW1lLCB0aGVzZSB0aHJl
YWRzIGFyZSB3b2tlbiB1cCBieSB0aGUgZnJlZXplciBzb2xlbHkgdG8KdHJhbnNpdGlvbiB0byBU
QVNLX0ZST1pFTiwgYW5kIHdva2VuIGFnYWluIHVwb24gdGhhdyBvbmx5IHRvIHJlLWV2YWx1YXRl
CmZpbGUgZGVzY3JpcHRvcnMgd2l0aCBubyBwZW5kaW5nIGFjdGl2aXR5IGFuZCBzbGVlcCBhZ2Fp
bi4KCkEgcHJldmlvdXMgYXR0ZW1wdCB0byBtYWtlIHNlbGVjdCgpIGFuZCBwb2xsKCkgZnJlZXph
YmxlIGluIGNvbW1pdAo5NzQ1Y2RiMzZkYTggKCJzZWxlY3Q6IHVzZSBmcmVlemFibGUgYmxvY2tp
bmcgY2FsbCIpIHdhcyByZXZlcnRlZCBpbgpjb21taXQgNTk2MTJkMTg3OTEyICgiUmV2ZXJ0ICJz
ZWxlY3Q6IHVzZSBmcmVlemFibGUgYmxvY2tpbmcgY2FsbCIiKQphbG9uZ3NpZGUgdGhlIGVwb2xs
IHJldmVydCBkdWUgdG8gaXNzdWVzIGNhdXNlZCBieSB0aGUgbGVnYWN5IGZyZWV6ZXIKYXJjaGl0
ZWN0dXJlLgoKRm9sbG93aW5nIHRoZSBmcmVlemVyIG92ZXJoYXVsIGluIGNvbW1pdCBmNWQzOWIw
MjA4MDkgKCJmcmVlemVyLHNjaGVkOgpSZXdyaXRlIGNvcmUgZnJlZXplciBsb2dpYyIpLCB0YXNr
cyBpbiBUQVNLX0ZSRUVaQUJMRSBhcmUgc2FmZWx5IGZyb3plbgppbi1wbGFjZSBpbnRvIFRBU0tf
RlJPWkVOIHdpdGhvdXQgcnVubmluZyB1c2Vyc3BhY2UgY29kZSBvciBleHBlcmllbmNpbmcKcHJl
bWF0dXJlIHdha2V1cHMgYmVmb3JlIHJlc3VtZSBjb21wbGV0ZXMuCgpQYXNzIFRBU0tfRlJFRVpB
QkxFIHRvIHBvbGxfc2NoZWR1bGVfdGltZW91dCgpIGluIGRvX3NlbGVjdCgpIGFuZApkb19wb2xs
KCkgKFRBU0tfSU5URVJSVVBUSUJMRSB8IFRBU0tfRlJFRVpBQkxFKSBzbyB0aGF0IHBvbGxpbmcg
dGhyZWFkcwpyZW1haW4gYXNsZWVwIHVuZGlzdHVyYmVkIGFjcm9zcyBzdXNwZW5kL3Jlc3VtZSBj
eWNsZXMuCgpSZXZpZXdlZC1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KU2lnbmVkLW9mZi1i
eTogU2FkcnVsIENob3dkaHVyeSA8c2FkcnVsQGdvb2dsZS5jb20+Ci0tLQogZnMvc2VsZWN0LmMg
fCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvc2VsZWN0LmMgYi9mcy9zZWxlY3QuYwppbmRleCA4OTQzZjIwZTgz
MDAuLjVjYmJlODYxMzViYyAxMDA2NDQKLS0tIGEvZnMvc2VsZWN0LmMKKysrIGIvZnMvc2VsZWN0
LmMKQEAgLTYwMSw3ICs2MDEsNyBAQCBzdGF0aWMgbm9pbmxpbmVfZm9yX3N0YWNrIGludCBkb19z
ZWxlY3QoaW50IG4sIGZkX3NldF9iaXRzICpmZHMsIHN0cnVjdCB0aW1lc3BlYwogCQkJdG8gPSAm
ZXhwaXJlOwogCQl9CiAKLQkJaWYgKCFwb2xsX3NjaGVkdWxlX3RpbWVvdXQoJnRhYmxlLCBUQVNL
X0lOVEVSUlVQVElCTEUsCisJCWlmICghcG9sbF9zY2hlZHVsZV90aW1lb3V0KCZ0YWJsZSwgVEFT
S19JTlRFUlJVUFRJQkxFIHwgVEFTS19GUkVFWkFCTEUsCiAJCQkJCSAgIHRvLCBzbGFjaykpCiAJ
CQl0aW1lZF9vdXQgPSAxOwogCX0KQEAgLTk2MSw3ICs5NjEsNyBAQCBzdGF0aWMgaW50IGRvX3Bv
bGwoc3RydWN0IHBvbGxfbGlzdCAqbGlzdCwgc3RydWN0IHBvbGxfd3F1ZXVlcyAqd2FpdCwKIAkJ
CXRvID0gJmV4cGlyZTsKIAkJfQogCi0JCWlmICghcG9sbF9zY2hlZHVsZV90aW1lb3V0KHdhaXQs
IFRBU0tfSU5URVJSVVBUSUJMRSwgdG8sIHNsYWNrKSkKKwkJaWYgKCFwb2xsX3NjaGVkdWxlX3Rp
bWVvdXQod2FpdCwgVEFTS19JTlRFUlJVUFRJQkxFIHwgVEFTS19GUkVFWkFCTEUsIHRvLCBzbGFj
aykpCiAJCQl0aW1lZF9vdXQgPSAxOwogCX0KIAlyZXR1cm4gY291bnQ7Ci0tIAoyLjU2LjAuMzg1
LmdkM2FjYjkwZWY4LWdvb2cKCg==
--000000000000c552f3065dbe8eaa--
