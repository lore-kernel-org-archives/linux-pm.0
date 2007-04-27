From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Fri, 27 Apr 2007 17:31:42 +0200
Message-ID: <200704271731.43040.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<200704271700.52678.rjw@sisk.pl> <46320FC3.7030202@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46320FC3.7030202@cs.helsinki.fi>
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
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Friday, 27 April 2007 16:59, Pekka Enberg wrote:
> Rafael J. Wysocki wrote:
> > Please have a look at the freezer changes queued up in -mm and the freezer
> > patches recently sent.
> 
> I don't think it clashes when I do the changes suggested by Pavel.

Yes, you're probably right.
