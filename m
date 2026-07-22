Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1A1DF736;
	Wed, 22 Jul 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724820; cv=none; b=ScATEK5HBdOfh4u4lUJ8WeZeZzPMWIf4daWo16nY7O97hUGMxuqY2+bopUgCtnrNYH+TnalrRaLifLqCvuJdTR+iFe/qvSkMNiUpKyTE59BaV44CIJ9EBBYvFlfs91AoA3H4MBty/Sjf/d2FLKlPQVV8+K7LQI8uRsa/ZfkUzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724820; c=relaxed/simple;
	bh=ycx5+RKtiUjTFBuLnnJqeFfaFVvwoSTZp2zPfYDiL90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngi6tTQ5T7bm89LTICz/WwOTnCMXFsPEyACbwzA6anJsTeEF65VTEhJNSXkj5hWahmlMM/iSB5BEP1J61qnEhy3ig0ShqcxossXdZFLTnhMJG5Hr+XYWK9JXveRKRKglPeH2dccQNFdmmRtKiO8zoR8MQmSY+SFzsoO2ZnYVM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7KymtW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7KymtW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CD51F000E9;
	Wed, 22 Jul 2026 12:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724815;
	bh=KuOY/nwET7kpTgEI3t8O9xiBb0RbvPVNv8KLvnHIM4U=;
	h=From:To:Cc:Subject:Date;
	b=O7KymtW6HIZpw3JklxdEinJZHPLhu00J+zxTFqY1KAOLVxubHa5caIb7cfnh4wn6P
	 yYpCuNNrEXPh+qPQF/ci+a3YbEkkKJGhyN8bFZdK/3V8mycZM1tlSSTF0xfGsEWldE
	 d3igpNbQBpD7Wup6kbZ4B2sKb31vb3Psl14eZ7xf5zj01pIE18oP28AjijsedzKitV
	 g+eNidmM/KTSrqBu5+B+lHDzQ7qKjaB67TvQmSZISFgOIUuMPYRLl2qFwSgprL4wt6
	 dPECbFzEUmAsxQYqTUgGO90kV2gntIzK8waOaQrb7amMzb3Rt//MgjI+e3dVQzpwtw
	 53x5bqnZk9nwQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1][linux-next] intel_idle: Update documentation after adding ACPI
 _LPI support
Date: Wed, 22 Jul 2026 14:53:31 +0200
Message-ID: <12962673.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After adding ACPI _LPI support to intel_idle, update its admin-guide
documentation to cover the changed behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_idle.rst |   54 ++++++++++++++++------------
 1 file changed, 31 insertions(+), 23 deletions(-)

--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -87,17 +87,22 @@ tables with any processor model recogniz
 `below <intel-idle-parameters_>`_.]
 
 If the ACPI tables are going to be used for building the list of available idle
-states, ``intel_idle`` first looks for a ``_CST`` object under one of the ACPI
-objects corresponding to the CPUs in the system (refer to the ACPI specification
-[2]_ for the description of ``_CST`` and its output package).  Because the
-``CPUIdle`` subsystem expects that the list of idle states supplied by the
-driver will be suitable for all of the CPUs handled by it and ``intel_idle`` is
-registered as the ``CPUIdle`` driver for all of the CPUs in the system, the
-driver looks for the first ``_CST`` object returning at least one valid idle
-state description and such that all of the idle states included in its return
-package are of the FFH (Functional Fixed Hardware) type, which means that the
-``MWAIT`` instruction is expected to be used to tell the processor that it can
-enter one of them.  The return package of that ``_CST`` is then assumed to be
+states, ``intel_idle`` will be looking for ``_LPI`` or ``_CST`` objects in them
+(refer to the ACPI specification [2]_ for the definitions of the ``_LPI`` and
+``_CST`` objects).  If ``_LPI`` is present under at least one of the ACPI
+objects representing the CPUs in the system and ``_LPI`` processing produces a
+non-empty list of valid idle states, it will be used.  Otherwise, ``_CST`` will
+be used so long as it is present under at least one of the ACPI objects
+representing the CPUs in the system and it returns a non-empty list of valid
+idle states.  In either case, since the ``CPUIdle`` subsystem expects that the
+list of idle states supplied by the driver will be suitable for all of the CPUs
+handled by it and ``intel_idle`` is registered as the ``CPUIdle`` driver for all
+of the CPUs in the system, ``intel_idle`` looks for the first CPU where the
+ACPI-supplied list of idle states (coming from either ``_LPI`` or ``_CST``)
+is not empty.  Moreover, all of the states in that list need to be of the FFH
+(Functional Fixed Hardware) type, which means that the ``MWAIT`` instruction is
+expected to be used to tell the processor that the given idle state may be
+entered.  If that expectation is met, the list of idle states is assumed to be
 applicable to all of the other CPUs in the system and the idle state
 descriptions extracted from it are stored in a preliminary list of idle states
 coming from the ACPI tables.  [This step is skipped if ``intel_idle`` is
@@ -129,18 +134,21 @@ If the given processor model is not reco
 supports ``MWAIT``, the preliminary list of idle states coming from the ACPI
 tables is used for building the final list that will be supplied to the
 ``CPUIdle`` core during driver registration.  For each idle state in that list,
-the description, ``MWAIT`` hint and exit latency are copied to the corresponding
-entry in the final list of idle states.  The name of the idle state represented
-by it (to be returned by the ``name`` idle state attribute in ``sysfs``) is
-"CX_ACPI", where X is the index of that idle state in the final list (note that
-the minimum value of X is 1, because 0 is reserved for the "polling" state), and
-its target residency is based on the exit latency value.  Specifically, for
-C1-type idle states the exit latency value is also used as the target residency
-(for compatibility with the majority of the "internal" tables of idle states for
-various processor models recognized by ``intel_idle``) and for the other idle
-state types (C2 and C3) the target residency value is 3 times the exit latency
-(again, that is because it reflects the target residency to exit latency ratio
-in the majority of cases for the processor models recognized by ``intel_idle``).
+the description, ``MWAIT`` hint and exit (wake) latency are copied to the
+corresponding entry in the final list of idle states.  If the preliminary list
+of idle states has been obtained through ``_LPI`` processing, the minimum
+residency parameter of the given idle state is taken as its target residency.
+Otherwise, for C1-type idle states, the exit latency value is also used as the
+target residency (for compatibility with the majority of the "internal" tables
+of idle states for various processor models recognized by ``intel_idle``), and
+for the other idle state types (C2 and C3) the target residency value is 3 times
+the exit latency (again, that is because it reflects the target residency to
+exit latency ratio in the majority of cases for the processor models recognized
+by ``intel_idle``).  The name of the idle state (to be returned by the ``name``
+idle state attribute in ``sysfs``) is either "Cx_LPI" (if it comes from ``_LPI``
+processing) or "Cx_ACPI", where x is the index of that idle state in the final
+list (note that the minimum value of x is 1, because 0 is reserved for the
+"polling" state), and its target residency is based on the exit latency value.
 All of the idle states in the final list are enabled by default in this case.
 
 



