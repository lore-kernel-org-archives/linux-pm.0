From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [3/3] 2.6.22-rc4: known regressions v2
Date: Sat, 09 Jun 2007 19:40:29 +0200
Message-ID: <466AE60D.8030606@googlemail.com>
References: <466ADBE4.5090707@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <466ADBE4.5090707@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: discuss@x86-64.org, Tejun Heo <htejun@gmail.com>, Ioan Ionita <opslynx@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Alex Riesen <raa.lkml@gmail.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc4.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Suspend

Subject    : hibernate(?) fails totally - regression
References : http://lkml.org/lkml/2007/6/1/401
Submitter  : David Greaves <david@dgreaves.com>
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
Caused-By  : Tejun Heo <htejun@gmail.com>
             commit 9666f4009c22f6520ac3fb8a19c9e32ab973e828
Status     : problem is being debugged



TTY

Subject    : OOPS (NULL pointer dereference) in v2.6.22-rc3
References : http://lkml.org/lkml/2007/6/1/389
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8473
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8574
Submitter  : Alex Riesen <raa.lkml@gmail.com>
Status     : problem is being debugged



x86-64

Subject    : x86-64 2.6.22-rc2 random segfaults
References : http://lkml.org/lkml/2007/5/24/275
Submitter  : Ioan Ionita <opslynx@gmail.com>
Status     : Unknown



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
