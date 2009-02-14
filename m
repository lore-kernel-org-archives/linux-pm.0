From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 09/10] Input: Hold wake lock while event
	queue is not empty.
Date: Sat, 14 Feb 2009 00:18:14 +0000
Message-ID: <20090214001814.GA6287@srcf.ucam.org>
References: <20090212113126.GC28176@srcf.ucam.org>
	<d6200be20902121627k7ea21f21hba24a2616e27aa42@mail.gmail.com>
	<20090213003402.GA8393@srcf.ucam.org>
	<d6200be20902121638t62687ec6k6fc39055a41a78fa@mail.gmail.com>
	<20090213004054.GB8454@srcf.ucam.org>
	<d6200be20902121652u400c450emf5e7ded1b2ea23c@mail.gmail.com>
	<20090213005704.GA8721@srcf.ucam.org>
	<d6200be20902131551v434fb375g733933c971dbecd9@mail.gmail.com>
	<20090214000911.GB5764@srcf.ucam.org>
	<d6200be20902131613h17478479jd48cdcbd5c8256a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902131613h17478479jd48cdcbd5c8256a3@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 04:13:22PM -0800, Arve Hj=F8nnev=E5g wrote:

> Which is why I offered to make it configurable.

If you don't trust your userspace then your argument suggests every wake =

lock that faces userspace has to have a timeout. When the logical =

extension to an answer to a problem is "Add a configuration option to =

almost every driver", you might want to rethink.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
