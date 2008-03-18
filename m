From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 19 Mar 2008 00:52:38 +0100
Message-ID: <20080318235238.GA1779__38463.6483424858$1205884507$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803131803.31120.rjw@sisk.pl>
	<m1ejaew7dm.fsf@ebiederm.dsl.xmission.com>
	<200803140231.39282.rjw@sisk.pl>
	<m1prtsug2e.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m1prtsug2e.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

> Does using the S4 state have advantages that I currently do not
> see?

Yes. S5 confuses BIOSes on some machines (HP nx5000), and they report
stale values for AC/battery power (and worse, like thermal management
broken).

But this should not stop kexec/kjump.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
