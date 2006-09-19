From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/2
Date: Tue, 19 Sep 2006 16:37:04 -0500 (CDT)
Message-ID: <200609192137.k8JLb4NX029061@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: "Eugeny S. Mints"'s message of Mon, 18 Sep 2006 23:58:04 +0400
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: eugeny.mints@gmail.com
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

From: "Eugeny S. Mints" <eugeny.mints@gmail.com>

| Eugeny S. Mints wrote:
| > Pavel Machek wrote:
| >> Hi!
| >>
| [skip]
| >> How is it going to work on 8cpu box? will
| >> you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
| =

| basically I guess you are asking about what the names of operating
| points are and how to distinguish between operating points from
| userspace on 8cpu box.
| =

| An advantage of PowerOP approach is that operating point name is used as
| a _handle_ and may or may not be meaningful. The idea is that if a
| policy manager needs to make a decision and needs to distinguish between
| operating points it can check value of any power parameters of operating
| points in question. Power parameter values may be obtained under
| <op_name> dir name.
| =

| With such approach a policy manger may compare operating points at
| runtime and should not rely on compile time knowledge about what name
| corresponds to what set of power parameter values. It uses name as a
| handle.
---

Hmm. If you assume the CPUs in an SMP system can be in different
operating points, this would (as Pavel pointed out) result in an
explosion of operating points.

I see several possible responses to this problem:

(1) Make operating points a CPU-level abstraction, rather than a
system-level abstraction, with the set of OPs for each CPU defined
individually. This allows for non-symmetric CPUs. Each CPU would have
its own policy manager driving OP selection for that CPU (the set of
policy managers could be shared, as I believe cpufreq shares governors
among CPU).

(2) Create CPU-group operating points that captured the power
parameters for each of a set of CPUs (that is, a group OP would be a
vector of CPU OPs).

(3) Create CPU-group operating points that varied a group of CPUs
symetrically (that is, one set of CPU-level power parameters shared
across a set of CPUs), with group-level policy managers that control
transitions for the group in lockstep. =


(4) Create CPU-group operating points that varied a group of CPUs
symetrically (as in (3)), and have both group-level policy managers and
a system-level policy manager that moves CPUs from one group to
another.

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
