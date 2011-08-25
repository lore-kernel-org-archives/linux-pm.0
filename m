From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/6] cgroup,
	cpuset: don't use ss->pre_attach()
Date: Thu, 25 Aug 2011 11:06:26 +0200
Message-ID: <20110825090626.GE3286__33812.6494935297$1314263337$gmane$org@htj.dyndns.org>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-6-git-send-email-tj@kernel.org>
	<CALdu-PD5EbFJBRHf-iehPwb6vyJTYUTWZniihARFDZ7xRZ8_nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALdu-PD5EbFJBRHf-iehPwb6vyJTYUTWZniihARFDZ7xRZ8_nQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Menage <paul@paulmenage.org>
Cc: containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 25, 2011 at 01:53:57AM -0700, Paul Menage wrote:
> On Tue, Aug 23, 2011 at 3:19 PM, Tejun Heo <tj@kernel.org> wrote:
> > ->pre_attach() is supposed to be called before migration, which is
> > observed during process migration but task migration does it the other
> > way around. =A0The only ->pre_attach() user is cpuset which can do the
> > same operaitons in ->can_attach(). =A0Collapse cpuset_pre_attach() into
> > cpuset_can_attach().
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> =

> Acked-by: Paul Menage <paul@paulmenage.org>
> =

> Code looks good, but I think that the some of the Documentation
> changes slipped in here by mistake.

Oops, indeed.  Will relocate them.

Thanks.

-- =

tejun
