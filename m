From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 05/11] PM: Enable early suspend through
	/sys/power/state
Date: Mon, 2 Feb 2009 14:36:04 -0800
Message-ID: <d6200be20902021436y6b0f92fcv4228246a191a63aa@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-2-git-send-email-arve@android.com>
	<1231896476-22445-3-git-send-email-arve@android.com>
	<1231896476-22445-4-git-send-email-arve@android.com>
	<1231896476-22445-5-git-send-email-arve@android.com>
	<1231896476-22445-6-git-send-email-arve@android.com>
	<20090128193409.GC1222@ucw.cz>
	<d6200be20901301913wbb5d496wa599edddcf93674f@mail.gmail.com>
	<20090202114514.GB4631@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090202114514.GB4631@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 2, 2009 at 3:45 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Yes, goal is that compiling in  wakelock / early suspend support has
> no effect on existing functionality.

OK. I think I'll just print a warning and disable wakelock support if
user-space writes to /sys/power/state when wakelock support is
compiled in. A wakelock aware power manager in user-space can use an
always non-blocking interface (e.g. /sys/power/request_state) instead.

-- =

Arve Hj=F8nnev=E5g
