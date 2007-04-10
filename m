From: "Sascha Heid" <saschaheid@gmail.com>
Subject: Re: resume sometimes reboots or freezes Laptop,
	trying to debug
Date: Tue, 10 Apr 2007 16:30:13 +0200
Message-ID: <1015f9200704100730g5f4798f9ia3f09187001f54c4@mail.gmail.com>
References: <1015f9200704071721y2599e571m6ef2a063478c2cc6@mail.gmail.com>
	<200704081828.27704.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704081828.27704.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Please try 2.6.21-rc6.  If it doesn't work, please file a bug report at >=
bugzilla.kernel.org .

I just got my first frozen resume with 2.6.21rc6 and got nothing but
this one line:
Magic number: 0:692:668

I had other problems additionally, Xorg crashed twice on the resume
and once it showed me funny ascii-art instead of my X Session.

Regarding a bug-report, i dont think anybody would care about such a
rare problem and on a rc-kernel.
What information could i supply anyways? Not much.

Looks like alot of acpi work is been done though, maybe in 2.6.22...
