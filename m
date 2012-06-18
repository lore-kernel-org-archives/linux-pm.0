From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: cpuidle future and improvements
Date: Mon, 18 Jun 2012 10:40:45 +0200
Message-ID: <4FDEE98D.7010802@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Amit Kucheria <amit.kucheria@linaro.org>, linux-next@vger.kernel.org, Colin Cross <ccross@android.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rob Lee <rob.lee@linaro.org>
List-Id: linux-pm@vger.kernel.org


Dear all,

A few weeks ago, Peter De Schrijver proposed a patch [1] to allow per
cpu latencies. We had a discussion about this patchset because it
reverse the modifications Deepthi did some months ago [2] and we may
want to provide a different implementation.

The Linaro Connect [3] event bring us the opportunity to meet people
involved in the power management and the cpuidle area for different SoC.

With the Tegra3 and big.LITTLE architecture, making per cpu latencies
for cpuidle is vital.

Also, the SoC vendors would like to have the ability to tune their cpu
latencies through the device tree.

We agreed in the following steps:

1. factor out / cleanup the cpuidle code as much as possible
2. better sharing of code amongst SoC idle drivers by moving common bits
to core code
3. make the cpuidle_state structure contain only data
4. add a API to register latencies per cpu

These four steps impacts all the architecture. I began the factor out
code / cleanup [4] and that has been accepted upstream and I proposed
some modifications [5] but I had a very few answers.

The patch review are very slow and done at the last minute at the merge
window and that makes code upstreaming very difficult. It is not a
reproach, it is just how it is and I would like to propose a solution
for that.

I propose to host a cpuidle-next tree where all these modifications will
be and where people can send patches against, preventing last minutes
conflicts and perhaps Lenb will agree to pull from this tree. In the
meantime, the tree will be part of the linux-next, the patches will be
more widely tested and could be fixed earlier.

Thanks
-- Daniel

[1] http://lwn.net/Articles/491257/
[2] http://lwn.net/Articles/464808/
[3] http://summit.linaro.org/
[4]
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67033.html,
http://www.spinics.net/lists/linux-pm/msg27330.html,
http://comments.gmane.org/gmane.linux.ports.arm.omap/76311,
http://www.digipedia.pl/usenet/thread/18885/11795/

[5] https://lkml.org/lkml/2012/6/8/375

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
