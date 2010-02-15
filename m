From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: syncing the disks when entering sleep
Date: Mon, 15 Feb 2010 20:28:55 +0000
Message-ID: <20100215202855.GA15382@srcf.ucam.org>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201002101158.22606.rjw@sisk.pl>
	<201002101202.54557.oliver@neukum.org>
	<201002101942.43706.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201002101942.43706.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 10, 2010 at 07:42:43PM +0100, Rafael J. Wysocki wrote:

> That would matter if sync meant mandatory flushing all data to the storage
> medium, but it doesn't.  From a filesystem point of view it's an advisory
> thing, something like "I wish you flushed buffers right now".

It's defined as forcing actual writing on Linux. It doesn't guarantee 
that it'll be consistent (eg, XFS may flush to the journal rather than 
the filesystem), but it should mean that all cached data is on disk in 
some form.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
