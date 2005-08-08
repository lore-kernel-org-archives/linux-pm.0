From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH] Workqueue freezer support.
Date: Mon, 08 Aug 2005 22:18:57 +1000
Message-ID: <1123503537.3969.525.camel@localhost>
References: <1121923059.2936.224.camel@localhost>
	<Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
	<1123243967.3266.2.camel@localhost>
	<Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75982127687094003=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>, Christoph Lameter <christoph@lameter.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============75982127687094003==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok. Now that I've actually done some work toward getting it to work with
Suspend2, I'll give a more cogent response to Christoph's approach.

I believe it can work, but the algorithm in freeze() is a bit of a
concern.

Checking whether the todo list is empty is fine while we're the only
user, but when other functionality is using this, it will be unreliable.
We'll either need a quick way to check what todo work is pending for a
task (traverse list would be racy). We can't say "We know we signalled
them all already" because more might have forked.

One possibility might be to leverage the existing counting - when
num_signalled = num_frozen, we can signal a new batch with impunity. But
this assumes everything signalled properly enters the fridge (which
might not always be guaranteed).

Perhaps it's best to keep PF_FREEZING? Perhaps there's another
possibility.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============75982127687094003==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============75982127687094003==--
