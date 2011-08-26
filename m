From: Paul Menage <paul@paulmenage.org>
Subject: Re: [PATCHSET] cgroup: introduce cgroup_taskset and
 consolidate subsys methods, take#2
Date: Fri, 26 Aug 2011 07:56:09 -0700
Message-ID: <CALdu-PBthm1AcRX1UOAQEpXVWMU60UEPjMEcLDig3vZOawT9-A__47503.9585181095$1314375858$gmane$org@mail.gmail.com>
References: <1314312192-26885-1-git-send-email-tj@kernel.org>
	<4E5753D3.9080500@cn.fujitsu.com>
	<20110826140900.GF2632@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110826140900.GF2632@htj.dyndns.org>
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
Cc: fweisbec@gmail.com, containers@lists.linux-foundation.org, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, kamezawa.hiroyu@jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 26, 2011 at 7:09 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Fri, Aug 26, 2011 at 04:05:39PM +0800, Li Zefan wrote:
>> It's fine for me to route those patches through pm-freezer, since this
>> work is initiated and needed for the work on freezer.
>
> Awesome. =A0Paul, what do you think? =A0Rafael, if Paul agrees, can you
> please take in this series?
>

Sure - but can you make sure that there's nothing in -mm that
conflicts with this patchset? If there is, then maybe cherry-pick
those into pm-freezer too, and fix them up?

Paul
