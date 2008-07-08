From: "Paul Menage" <menage@google.com>
Subject: Re: [PATCH 0/4] Container Freezer: Reuse Suspend Freezer
Date: Tue, 8 Jul 2008 13:06:32 -0700
Message-ID: <6599ad830807081306l61622eadk215a25d02ee94b00@mail.gmail.com>
References: <20080707225823.502032693@us.ibm.com>
	<20080708123150.3034d83f.kamezawa.hiroyu@jp.fujitsu.com>
	<1215545954.9023.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1215545954.9023.120.camel@localhost.localdomain>
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, linux-pm@lists.linux-foundation.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 8, 2008 at 12:39 PM, Matt Helsley <matthltc@us.ibm.com> wrote:
>
> One is to try and disallow users from moving frozen tasks. That doesn't
> seem like a good approach since it would require a new cgroups interface
> "can_detach()".

Detaching from the old cgroup happens at the same time as attaching to
the new cgroup, so can_attach() would work here.

Paul
