From: Stefan Seyfried <seife@suse.de>
Subject: Re: freeze_processes questions
Date: Thu, 28 Apr 2005 17:19:45 +0200
Message-ID: <4270FF11.70305@suse.de>
References: <1114595634.7918.25.camel@desktop.cunningham.myip.net.au>	<1114663706.22110.35.camel@sli10-desk.sh.intel.com>
	<20050428081435.GE1906@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050428081435.GE1906@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!

> How can usespace processes depend on each other? By definition user
> task sleeps in place where it holds no locks... it can't block anyone.

what was the problem with mysql some months back? I never fully
understood it, but wasn't it 2 mysql processes communicating via a pipe
or something like that and the "wrong end" frozen first?
--=20
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX N=FCrnberg.

"Any ideas, John?"
"Well, surrounding them's out."
