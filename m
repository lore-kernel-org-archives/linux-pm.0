From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -v4 6/6] fault-injection: add notifier error
 injection testing scripts
Date: Tue, 26 Jun 2012 16:31:47 -0700
Message-ID: <20120626163147.93181e21.akpm@linux-foundation.org>
References: <1340463502-15341-1-git-send-email-akinobu.mita@gmail.com>
	<1340463502-15341-7-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1340463502-15341-7-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Sat, 23 Jun 2012 23:58:22 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This adds two testing scripts with notifier error injection

Can we move these into tools/testing/selftests/, so that a "make
run_tests" runs these tests?

Also, I don't think it's appropriate that "fault-injection" be in the
path - that's an implementation detail.  What we're testing here is
memory hotplug, pm, cpu hotplug, etc.  So each test would go into, say,
tools/testing/selftests/cpu-hotplug.

Now, your cpu-hotplug test only tests a tiny part of the cpu-hotplug
code.  But it is a start, and creates the place where additional tests
will be placed in the future.


If the kernel configuration means that the tests cannot be run, the
attempt should succeed so that other tests are not disrupted.  I guess
that printing a warning in this case is useful.

Probably the selftests will require root permissions - we haven't
really thought about that much.  If these tests require root (I assume
they do?) then a sensible approach would be to check for that and to
emit a warning and return "success".

My overall take on the fault-injection code is that there has been a
disappointing amount of uptake: I don't see many developers using them
for whitebox testing their stuff.  I guess this patchset addresses
that, in a way.
