From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/6] cgroup: improve old cgroup handling in
 cgroup_attach_proc()
Date: Thu, 25 Aug 2011 11:44:59 +0200
Message-ID: <20110825094459.GH3286__41810.40664339$1314265693$gmane$org@htj.dyndns.org>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-3-git-send-email-tj@kernel.org>
	<CALdu-PBr-tu1qzScvncr-N4EpPaQ7sTdHf28GhEv_MZLbo1eSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALdu-PBr-tu1qzScvncr-N4EpPaQ7sTdHf28GhEv_MZLbo1eSg@mail.gmail.com>
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

On Thu, Aug 25, 2011 at 02:42:46AM -0700, Paul Menage wrote:
> > + =A0 =A0 =A0 int retval, i, group_size, nr_todo;
> =

> I'd be inclined to call "nr_todo" something like "nr_migrating_tasks"
> for clarity.

Will update.

Thanks.

-- =

tejun
