From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 11:01:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803121055510.4595-100000__31374.6248641566$1205334309$gmane$org@iolanthe.rowland.org>
References: <1205286937.29875.9.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1205286937.29875.9.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Mar 2008, Huang, Ying wrote:

> I think "kexec based hibernation" is the only currently available
> possible method to write out image without freezer (after driver works
> are done). If other process is running, how to prevent them from writing
> to disk without freezing them in current implementation?

This is a very good question.

It's a matter of managing the block layer's request queues.  Somehow 
the existing I/O requests must remain blocked while the requests needed 
for writing the image must be allowed to proceed.

I don't know what would be needed to make this work, but it ought to be 
possible somehow...

Alan Stern
